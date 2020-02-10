import 'package:flutter/widgets.dart';
import 'package:flutter_percentage/screens/calculate_screen.dart';
import 'package:flutter_percentage/screens/home_screen.dart';

class PercentRoute {
  static const String HOME = "/";
  static const String CALCULATE = "/calculate";
}

var appRoute = {
  PercentRoute.HOME: (BuildContext context) => HomeScreen(),
  PercentRoute.CALCULATE: (BuildContext context) => CalculateScreen()
};