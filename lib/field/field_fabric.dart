import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_percentage/validator/form_validator.dart';

class FieldFabric {
  BuildContext context;

  FieldFabric(this.context);

  Widget createPercentField(Function(String) onSaved) => _rowWidget(
      Text(
        "Процентная ставка",
        style: Theme.of(context).textTheme.subhead,
      ),
      TextFormField(
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: _getDoubleFormatterWithLimit(),
          decoration: InputDecoration(hintText: "10", errorMaxLines: 4),
          validator: (value) => value.checkMaxPercent(),
          onSaved: (value) => onSaved(value)));

  Widget createDepositField(Function(String) onSaved) =>
      _defaultInput("Первоначальный депозит", onSaved);

  Widget createMoneyAddInMonthField(Function(String) onSaved) =>
      _defaultInput("Ежемесячное пополнение", onSaved);

  Widget createCancelMonthIncreaseField(Function(String) onSaved) =>
      _defaultInputWithLimit("С какого месяца не пополнять", onSaved);

  Widget createYearContributionField(Function(String) onSaved) =>
      _defaultInputWithLimit("На сколько лет вклад", onSaved, hint: "1");

  Widget createNumbersOfDepositorsField(Function(String) onSaved) =>
      _defaultInputWithLimit("Количество вкладчиков", onSaved, hint: "1");

  Widget createTakeOffInMonthField(Function(String) onSaved) =>
      _defaultInputWithLimit("С какого месяца снимать", onSaved);

  Widget createStopMonthTakeOfField(Function(String) onSaved) =>
      _defaultInputWithLimit("С какого месяца прекратить снимать", onSaved);

  Widget createCountMonthTakeOfField(Function(String) onSaved) =>
      _defaultInput("По сколько снимать", onSaved);

  List<TextInputFormatter> _getDoubleFormatterWithLimit({int limit = 3}) {
    return [
      BlacklistingTextInputFormatter(RegExp('[\\-|\\ |,]')),
      LengthLimitingTextInputFormatter(limit)
    ];
  }
  
  List<TextInputFormatter> _getDoubleFormatter({int limit = 3}) {
    return [
      BlacklistingTextInputFormatter(RegExp('[\\-|\\ |,]'))
    ];
  }

  Widget _defaultInputWithLimit(String name, Function(String) onSaved, { String hint: "0"}) {
    return _rowWidget(
        Text(name, style: Theme.of(context).textTheme.subhead),
        TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: _getDoubleFormatterWithLimit(),
            decoration: InputDecoration(hintText: hint, errorMaxLines: 4),
            onSaved: (value) => onSaved(value)));
  }

  Widget _defaultInput(String name, Function(String) onSaved, { String hint: "0"}) {
    return _rowWidget(
        Text(name, style: Theme.of(context).textTheme.subhead),
        TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: _getDoubleFormatter(),
            decoration: InputDecoration(hintText: hint, errorMaxLines: 4),
            onSaved: (value) => onSaved(value)));
  }

  Widget _rowWidget(Widget title, Widget field) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 16.0),
              child: title,
            ),
          ),
          Container(
            width: 70,
            child: field,
          )
        ],
      ),
    );
  }
}
