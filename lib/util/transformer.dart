double doubleOrDefault(String value, double def) {
  if (value.isEmpty) {
    return def;
  } else {
    return double.tryParse(value)?.toDouble();
  }
}
