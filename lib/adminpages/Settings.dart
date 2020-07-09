import 'package:flutter/material.dart';
import '../ComponentsAndConstants/flags.dart';

import '../ComponentsAndConstants/constants.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}



class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.child_friendly, color: Colors.black, size: 30),
                  Text(
                    "HELMET STATUS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0,
                        letterSpacing: 2),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    height: 40.0,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: helmetflag
                          ? Colors.greenAccent[100]
                          : Colors.redAccent[100].withOpacity(0.5),
                    ),
                    child: Stack(
                      children: <Widget>[
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.easeIn,
                          top: 3.0,
                          left: helmetflag ? 60.0 : 0.0,
                          right: helmetflag ? 0.0 : 60.0,
                          child: InkWell(
                            onTap: helmetStatusButton,
                            child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 100),
                                // ignore: missing_return
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return RotationTransition(
                                    child: child,
                                    turns: animation,
                                  );
                                },
                                child: helmetflag
                                    ? Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                        size: 35.0,
                                      )
                                    : Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red,
                                        size: 35.0,
                                      )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.directions_car, color: Colors.black, size: 30),
                  Text(
                    "DEFAULT VEHICLE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0,
                        letterSpacing: 2),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    height: 40.0,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: defaultEnabled
                          ? Colors.greenAccent[100]
                          : Colors.redAccent[100].withOpacity(0.5),
                    ),
                    child: Stack(
                      children: <Widget>[
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.easeIn,
                          top: 3.0,
                          left: defaultEnabled ? 60.0 : 0.0,
                          right: defaultEnabled ? 0.0 : 60.0,
                          child: InkWell(
                            onTap: defaultVehicleButton,
                            child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 100),
                                // ignore: missing_return
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return RotationTransition(
                                    child: child,
                                    turns: animation,
                                  );
                                },
                                child: defaultEnabled
                                    ? Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                        size: 35.0,
                                      )
                                    : Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red,
                                        size: 35.0,
                                      )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.rss_feed, color: Colors.black, size: 30),
                  Text(
                    "RFID STATUS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0,
                        letterSpacing: 2),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    height: 40.0,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: rfidflag
                          ? Colors.greenAccent[100]
                          : Colors.redAccent[100].withOpacity(0.5),
                    ),
                    child: Stack(
                      children: <Widget>[
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.easeIn,
                          top: 3.0,
                          left: rfidflag ? 60.0 : 0.0,
                          right: rfidflag ? 0.0 : 60.0,
                          child: InkWell(
                            onTap: rfidStatusButton,
                            child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 100),
                                // ignore: missing_return
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return RotationTransition(
                                    child: child,
                                    turns: animation,
                                  );
                                },
                                child: rfidflag
                                    ? Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                        size: 35.0,
                                      )
                                    : Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red,
                                        size: 35.0,
                                      )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    fetchFlag();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF3383CD),
                        kbuttonColor,
                      ],
                    ),
                    color: kbuttonColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 75),
                  child: Text(
                    'GET FLAGS',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0,
                        letterSpacing: 5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  helmetStatusButton() {
    setState(() {
      helmetflag = !helmetflag;
    });
  }

  defaultVehicleButton() {
    setState(() {
      defaultEnabled = !defaultEnabled;
    });
  }

  rfidStatusButton() {
    setState(() {
      rfidflag = !rfidflag;
    });
  }
}
