import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pms/Open.dart';
import 'ComponentsAndConstants/constants.dart';

void main() {
  runApp(Starting());
}

class Starting extends StatefulWidget {
  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        accentColor: kaccentColor,
      ),
      home: SplashScreen(),
    );
  }
}
