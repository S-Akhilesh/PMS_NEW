import 'package:flutter/material.dart';
import 'package:pms/ComponentsAndConstants/textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ComponentsAndConstants/flags.dart';
import '../ComponentsAndConstants/constants.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

TextEditingController cHost = TextEditingController();

class _SettingsState extends State<Settings> {
//  FlagSetState FlagsSet = new FlagSetState();

  @override
  Widget build(BuildContext context) {
    var urls;
    cHost.addListener(() {
      urls = cHost.text;
    });
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              BeautyTextfield(
                cornerRadius: BorderRadius.circular(50),
                width: 400,
                height: 70,
                inputType: TextInputType.text,
                prefixIcon: Icon(Icons.link),
                controller: cHost,
                placeholder: "HOST",
                onSubmitted: (text) {
                  host = text;
                },
              ),
              FlatButton(
                onPressed: () async {
                  urls = cHost.text;
                  SharedPreferences prefs = await SharedPreferences
                      .getInstance();
                  setState(() {
                    prefs.setString("host", urls);
                    host = urls;
                  });
                  showDialog(
                      context: context,
                      builder: (_)
                  =>
                      AlertDialog(
                        title: Text("STATUS"),
                        content: Text("HOST SET!"),
                        actions: [
                          IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      )
                  );
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
                    'SET HOST',
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

//  helmetStatusButton() {
//    setState(() {
//      helmetflag = !helmetflag;
//    });
//  }
//
//  defaultVehicleButton() {
//    setState(() {
//      defaultEnabled = !defaultEnabled;
//    });
//  }
//
//  rfidStatusButton() {
//    setState(() {
//      rfidflag = !rfidflag;
//    });
//  }
}
