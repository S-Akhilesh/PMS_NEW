import 'dart:math';

import 'package:flutter/cupertino.dart';

class Brain {
  Brain({@required this.weight, @required this.height});
  final int height, weight;
  double _bmi;

  String getResult() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getMessage() {
    if (_bmi >= 25)
      return "Overweight";
    else if (_bmi > 18.5)
      return "Normal";
    else
      return "Underweight";
  }

  String getResponse() {
    if (_bmi >= 25)
      return "You have higher than normal BMI, try exercising more";
    else if (_bmi > 18.5)
      return "Great!, you have normal body weight";
    else
      return "You have lower than normal BMI, try eating more";
  }

  double getBMI() {
    return _bmi;
  }
}
