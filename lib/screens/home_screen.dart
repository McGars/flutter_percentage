import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_percentage/model/percent_parameters.dart';
import 'package:flutter_percentage/util/transformer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  final PercentParameters _params = PercentParameters();

  appBarOptionMenu() => <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            child: Text(
              'Посчитать',
            ),
            textColor: Colors.white,
            onPressed: submit,
          ),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Set parameters"), actions: appBarOptionMenu()),
      body: Container(padding: EdgeInsets.all(16), child: createForm()),
    );
  }

  Widget createForm() {
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            createPercentField(),
            createDepositField(),
          ]),
    );
  }

  void submit() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
    }
  }

  Widget createPercentField() => _rowWidget(
      Text("Процентная ставка"),
      TextFormField(
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: _getDoubleFormatters(),
          decoration: InputDecoration(hintText: "10", errorMaxLines: 4),
          validator: (value) {
            var doubleValue = double.tryParse(value)?.toDouble();
            if (doubleValue != null && doubleValue > 100) {
              return 'Процентов не может быть больше 100';
            }
          },
          onSaved: (value) => _params.percent = doubleOrDefault(value, 10.0)));

  Widget createDepositField() => _rowWidget(
      Text("Первоначальный депозит"),
      TextFormField(
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: _getDoubleFormatters(),
          decoration: InputDecoration(hintText: "0", errorMaxLines: 4),
          onSaved: (value) => _params.deposit = doubleOrDefault(value, 0.0)));


  List<TextInputFormatter> _getDoubleFormatters() {
    return [
      BlacklistingTextInputFormatter(RegExp('[\\-|\\ |,]')),
      LengthLimitingTextInputFormatter(3)
    ];
  }
  
  Widget _rowWidget(Widget title, Widget child) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: title,
            ),
            flex: 2),
        SizedBox(
          width: 100,
          child: child,
        )
      ],
    );
  }
}
