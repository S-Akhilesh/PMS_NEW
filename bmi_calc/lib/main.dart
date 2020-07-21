import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'input_page.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF101639),
        scaffoldBackgroundColor: Color(0xFF0C1234),
        //backgroundColor: Color(0xFF0C1234),
      ),
      home: InputPage(),
    );
  }
}
