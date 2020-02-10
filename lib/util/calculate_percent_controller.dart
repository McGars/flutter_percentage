import 'package:flutter_percentage/model/percent_parameters.dart';
import 'package:flutter_percentage/model/percent_row_model.dart';

class CalculatePercentController {

  PercentParameters _params;

  double _addedByMonth = 0;

  double _allIncoming = 0;

  double _deposit = 0;

  CalculatePercentController(this._params) {
    _deposit = _params.deposit;
    print("deposit: $_deposit");
  }

  int getYearContribution() => _params.yearContribution;

  double calculatePercentInMonth() => _params.percent / 12;


  void calculateImcoming(PercentRowModel item, double monthPercent) {
    // проценты в каждом месяце
    item.incoming = (_deposit * monthPercent) / 100;

    _allIncoming += item.incoming;
    // увеличение депозита на проценты
    _deposit += item.incoming;
    // сколько денег сейчас на счете
    item.deposit += _deposit;
  }

  void addManualInMonth(PercentRowModel item, int position) {
    // пополняем до ограничения
    if (_params.moneyAddInMonthBreak == 0 || position < _params.moneyAddInMonthBreak) {
      _addedByMonth += _params.moneyAddInMonth;
      item.addedByMonth = _addedByMonth;
      _deposit += _params.moneyAddInMonth;
    }
  }

  void calculateLastIncoming(PercentRowModel item, double lastIncoming) {
    // разница между прошлым и текущим месяцем
    if (lastIncoming > 0) {
      item.diffWithPreviousMonth = item.incoming - lastIncoming;
    }
  }

  void calculateTakeOff(PercentRowModel item, int position) {
    // определяем необходимо ли снимать с депозита
    if (_params.takeOffCount <= 0 && _params.takeOffInMonth <= 0) return;

    if (_params.takeOffInMonth >= position && _params.takeOffInMonthStop <= position) {
      // снятие прибыли в месяц
      _deposit -= _params.takeOffCount;
      item.takeOffCount = _params.takeOffCount;
      _deposit -= item.takeOffCount;
    }
  }

  void calculateEarning(PercentRowModel item) {
    item.earnings = _allIncoming;
  }

}