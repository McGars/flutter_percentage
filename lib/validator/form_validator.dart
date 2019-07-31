
String decimalValidator(String value) {
  var doubleValue = double.tryParse(value)?.toDouble();
  if (doubleValue != null && doubleValue > 100) {
    return 'Процентов не может быть больше 100';
  }
}