
extension DecimalValidator on String {

  String checkMaxPercent() {
    var doubleValue = double.tryParse(this)?.toDouble() ?? 0;
    if (doubleValue > 100) {
      return 'Процентов не может быть больше 100';
    }
    return null;
  }

}