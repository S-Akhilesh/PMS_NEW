import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pms/ModelClasses/FlagMo.dart';

bool defaultEnabled,
    rfidflag,
    helmetflag,
    isConnected = false;

String host; // setting Wifi Printer Host in Admin Panel
String url;

class FlagSet extends StatefulWidget {
  @override
  FlagSetState createState() => FlagSetState();
}

class FlagSetState extends State<FlagSet> {
  var flags = new FlagMo();

  Future<void> fetchFlag() async {
    var response = await http.post('http://$url/NEW/Flag.php');
    try {
      if (response.statusCode == 200) {
        var flagJson = json.decode(response.body);
        for(var flag in flagJson){
          flags = FlagMo.fromJson(flag);
        }

        if (flags.helmetStatus == "0") {
          helmetflag = false;
        }
        if (flags.helmetStatus == "1") {
          helmetflag = true;
        }

        if (flags.rfidStatus == "0") {
          rfidflag = false;
        }
        if (flags.rfidStatus == "1") {
          rfidflag = true;
        }

        if (flags.defaultVtype == "0") {
          defaultEnabled = false;
        }
        if (flags.defaultVtype == "1") {
          defaultEnabled = true;
        }
      }
    } catch (Exception) {print("gotila");}
    print(rfidflag);
    print(defaultEnabled);
    print(helmetflag);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
