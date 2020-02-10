import 'package:flutter/material.dart';
import 'package:flutter_percentage/field/field_fabric.dart';
import 'package:flutter_percentage/model/percent_parameters.dart';
import 'package:flutter_percentage/util/transformer.dart';
import 'package:flutter_percentage/route/route.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  final PercentParameters _params = PercentParameters();

  FieldFabric fabric;

  appBarOptionMenu() => <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            child: Text('Посчитать'),
            textColor: Colors.white,
            onPressed: submit,
          ),
        )
      ];

  @override
  Widget build(BuildContext context) {
    fabric = FieldFabric(context);
    return Scaffold(
      appBar:
          AppBar(title: Text("Set parameters"), actions: appBarOptionMenu()),
      body: createForm(),
    );
  }

  Widget createForm() {
    return Form(
      key: _formKey,
      child:  SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(width: 16),
              fabric.createPercentField(
                  (value) => _params.percent = value.toDouble(10.0)),
              fabric.createDepositField(
                  (value) => _params.deposit = value.toDouble(.0)),
              fabric.createMoneyAddInMonthField(
                  (value) => _params.moneyAddInMonth = value.toInt(0)),
              fabric.createCancelMonthIncreaseField(
                  (value) => _params.moneyAddInMonthBreak = value.toInt(0)),
              fabric.createYearContributionField(
                  (value) => _params.yearContribution = value.toInt(1)),
              fabric.createNumbersOfDepositorsField(
                  (value) => _params.numberOfDepositors = value.toInt(1)),
              fabric.createTakeOffInMonthField(
                  (value) => _params.takeOffInMonth = value.toInt(0)),
              fabric.createStopMonthTakeOfField(
                  (value) => _params.takeOffInMonthStop = value.toInt(0)),
              fabric.createCountMonthTakeOfField(
                  (value) => _params.takeOffCount = value.toDouble(.0)),
              const SizedBox(width: 16)
            ]),
      ),
    );
  }

  void submit() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      Navigator.pushNamed(context, PercentRoute.CALCULATE, arguments: _params);
    }
  }
}
