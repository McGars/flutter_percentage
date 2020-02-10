extension NumberEx on String {

  double toDouble(double def) => double.tryParse(this)?.toDouble() ?? def;
  
  int toInt(int def) => int.tryParse(this)?.toInt() ?? def;

}
