import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pms/ComponentsAndConstants/flags.dart';
import 'package:pms/login_page.dart';
import 'ComponentsAndConstants/constants.dart';
import 'userstart.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool status = false;

//String token = '';
class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  FlagSetState FlagsSet = new FlagSetState();
  @override
  void initState() {
    FlagsSet.fetchFlag();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.indigo.withOpacity(0.7),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                kbuttonColor,
                kbuttonColor.withOpacity(0.5),
                Colors.white10,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Fusion",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                "Minds",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.deepPurple.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 5), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    status = prefs.getBool('isloggedIn');
    setState(() {
      url = prefs.getString("url");
      host = prefs.getString("host");
    });
    try {
      if (status == true && isConnected == true) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => UserStartPage()),
            (Route<dynamic> route) => false);
      }
      if (status == null || status == false || isConnected == false) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            (Route<dynamic> route) => false);
      }
    } catch (Exception) {}
  }
}
