import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weigthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _reset() {
    weigthController.text = '';
    heightController.text = '';

    setState(() {
      _infoText = 'Informe seus Dados';
    });
  }

  void calculate() {
    double weight = double.parse(weigthController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);

    setState(() {
      if (imc < 18.6)
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";

      if (imc >= 18.6 && imc < 24.9)
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";

      if (imc >= 24.9 && imc < 29.9)
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";

      if (imc >= 29.9 && imc < 34.9)
        _infoText = "Obsidade Grau I (${imc.toStringAsPrecision(3)})";

      if (imc >= 34.9 && imc < 30.9)
        _infoText = "Obsesidade Grau II (${imc.toStringAsPrecision(3)})";

      if (imc > 40)
        _infoText = "Obsesidade Grau III (${imc.toStringAsPrecision(3)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculo de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _reset,
            )
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120,
                    color: Colors.green,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Peso em (Kg)',
                        labelStyle:
                            TextStyle(color: Colors.green, fontSize: 25.0)),
                    controller: weigthController,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Informe seu Peso';
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Altura em (cm)',
                        labelStyle:
                            TextStyle(color: Colors.green, fontSize: 25.0)),
                    controller: heightController,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Informe seu Peso';
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.00, bottom: 20.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            calculate();
                          }
                        },
                        child: Text(
                          'Calcular',
                          style: TextStyle(color: Colors.white, fontSize: 40.0),
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    style: TextStyle(fontSize: 30, color: Colors.green),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )));
  }
}
