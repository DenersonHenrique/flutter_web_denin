import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados!";

  // Reset inputs.
  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  // Calculate IMC.
  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);
      if (imc < 18.6)
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      else if (imc >= 18.6 && imc < 24.9)
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      else if (imc >= 24.9 && imc < 29.9)
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      else if (imc >= 29.9 && imc < 34.9)
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      else if (imc >= 34.9 && imc < 39.9)
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      else if (imc >= 40)
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Create appbar.
        title: Text("Calculadora de IMC"),
        centerTitle: true, // Center title.
        backgroundColor: Colors.lightBlueAccent[400], // Background color.
        actions: <Widget>[
          // Add refresh icon.
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Fill the entire width of the crossed axis (horizontal).
            children: <Widget>[
              Icon(Icons.person_outline,
                  size: 120.0, color: Colors.lightBlueAccent[400]),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.lightBlueAccent[400])),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.lightBlueAccent[400], fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty)
                    return "Insira seu peso!";
                  else
                    return null;
                },
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle:
                          TextStyle(color: Colors.lightBlueAccent[400])),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.lightBlueAccent[400], fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Insira sua altura!";
                    else
                      return null;
                  }),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        calculate();
                        FocusScope.of(context)
                            .requestFocus(new FocusNode()); // Close keyboard.
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    // color: Colors.lightBlueAccent[400],
                  ),
                ),
              ),
              Text(
                "$_infoText",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.lightBlueAccent[400], fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
