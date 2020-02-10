import 'package:flutter/material.dart';
import 'package:flutter_percentage/model/percent_row_model.dart';
import 'package:flutter_percentage/util/calculate_percent_controller.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'dart:ui' as ui;

class CalculateScreen extends StatefulWidget {
  @override
  _CalculateScreenState createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  CalculatePercentController calculatePercentController;

  Jiffy _dateTime;
  String _dateFormat = "MM.yyyy";
  NumberFormat _currencyFormatter;

  @override
  Widget build(BuildContext context) {
    _dateTime = Jiffy();

    _currencyFormatter = NumberFormat.currency(
        locale: ui.window.locale.languageCode, symbol: "");

    calculatePercentController =
        CalculatePercentController(ModalRoute
            .of(context)
            .settings
            .arguments);

    return Scaffold(
      appBar: AppBar(title: Text("Result")),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              children: <Widget>[
                createInforPerMonthPercent(),
                createTable(),
              ],
            )));
  }

  Widget createInforPerMonthPercent() {
    var monthPercent = calculatePercentController.calculatePercentInMonth();
    var formattedPercent = monthPercent.toStringAsFixed(2);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("$formattedPercent% in month", style: Theme
          .of(context)
          .textTheme
          .headline6),
    );
  }

  Widget createTable() {
    return Table(columnWidths: {
      0: FlexColumnWidth(0.5),
      2: FlexColumnWidth(1.5),
      3: FlexColumnWidth(1.5),
    }, children: [
      _createHeaderTableRow(),
      ..._createValuesTableRow(),
    ]);
  }

  TableRow _createHeaderTableRow() {
    return TableRow(children: [
      Text("#"),
      Text("Date"),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text("Month add"),
      ),
      Text("Profit percent"),
      Text("Earnings"),
    ]);
  }

  List<TableRow> _createValuesTableRow() {
    var rows = <TableRow>[];
    var monthPercent = calculatePercentController.calculatePercentInMonth();
    var lastIncoming = 0.0;
    var iterateByYears = calculatePercentController.getYearContribution() * 12 +
        calculatePercentController.getYearContribution();
    for (var i = 1; i < iterateByYears; i++) {
      var item = PercentRowModel();

      item.date = _dateTime.format(_dateFormat);

      calculatePercentController.calculateImcoming(item, monthPercent);

      calculatePercentController.addManualInMonth(item, i);

      calculatePercentController.calculateLastIncoming(item, lastIncoming);

      calculatePercentController.calculateEarning(item);

      lastIncoming = item.incoming;

      rows.add(_createValueTableRow(i, item));

      _dateTime.add(months: 1);
    }

    return rows;
  }

  TableRow _createValueTableRow(int position, PercentRowModel item) {
    var captionStyle = Theme
        .of(context)
        .textTheme
        .caption;

    return TableRow(children: [
      Text("$position"),
      Text("${item.date}"),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("${_currencyFormatter.format(item.deposit)}"),
            Text(
              "${_currencyFormatter.format(item.addedByMonth)}",
              style: captionStyle,
            ),
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${_currencyFormatter.format(item.incoming)}"),
          if (item.diffWithPreviousMonth > 0.01)
            Row(
              children: <Widget>[
                Icon(
                  Icons.arrow_drop_up,
                  size: 14,
                  color: Colors.green,
                ),
                Text("${item.diffWithPreviousMonth.toStringAsFixed(2)}",
                    style: captionStyle.copyWith(color: Colors.green)),
              ],
            ),
          if (item.takeOffCount > 0)
            Text(
              "+${item.takeOffCount}",
              style: TextStyle(color: Colors.red),
            )
        ],
      ),
      Text("${_currencyFormatter.format(item.earnings)}"),
    ]);
  }
}
