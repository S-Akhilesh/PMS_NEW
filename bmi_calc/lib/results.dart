import 'package:bmi_calc/Cards.dart';
import 'package:bmi_calc/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  // ignore: non_constant_identifier_names
  Result(
      {@required this.result,
      @required this.interP,
      // ignore: non_constant_identifier_names
      @required this.ResultString});
  final String result;
  // ignore: non_constant_identifier_names
  final String ResultString;
  final String interP;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI CALCULATOR",
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w300),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomLeft,
              child: Text(
                "Your Result",
                style: TextStyle(
                    fontSize: 50,
                    letterSpacing: 2,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Cards(
              colors: kactiveCardcolor.withOpacity(0.5),
              cards: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    ResultString,
                    style: TextStyle(
                        fontSize: 25,
                        color: ResultString == "Normal"
                            ? Colors.green
                            : Colors.red),
                  ),
                  Text(
                    result,
                    style: TextStyle(fontSize: 100),
                  ),
                  Text(
                    interP,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
