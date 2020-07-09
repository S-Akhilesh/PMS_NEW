import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pms/ComponentsAndConstants/constants.dart';
import 'package:pms/ComponentsAndConstants/textfield.dart';
import 'package:pms/adminpages/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}
TextEditingController cUrl = TextEditingController();
class _AdminDashboardState extends State<AdminDashboard> {
  var urls;
  void sumne(){

  }
  @override
  Widget build(BuildContext context) {
    cUrl.addListener(() {
      urls = cUrl.text;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => Settings()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BeautyTextfield(
              cornerRadius: BorderRadius.circular(50),
              width: 400,
              height: 70,
              inputType: TextInputType.text,
              prefixIcon: Icon(Icons.link),
              controller: cUrl,
              placeholder: "URL",
              onSubmitted: (text) {
                urls = text;
              },
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              onPressed: () async {
                urls = cUrl.text;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("url",urls);
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
                  'SET URL',
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
    );
  }

}

