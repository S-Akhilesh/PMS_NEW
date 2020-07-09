import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pms/ModelClasses/FlagMo.dart';

bool defaultEnabled = true,
    rfidflag = true,
    helmetflag = true,
    isConnected = false;

String host = '$url'; // setting Wifi Printer Host in Admin Panel
String url;

class FlagSet extends StatefulWidget {
  @override
  FlagSetState createState() => FlagSetState();
}

class FlagSetState extends State<FlagSet> {
  var flags = new List<FlagMO>();

  Future<void> fetchFlag() async {
    var response = await http.post('http://$url/www/NEW/Flag.php');
    try {
      if (response.statusCode == 200) {
        print("Inside");
        var flagJson = json.decode(response.body);
        print(flagJson);
        for (var flag in flagJson) {
          flags.insert(0, FlagMO.fromJson(flag));
        }

        print("Inside");
        if (flags[0].helmetStatus as int == 0) {
          setState(() {
            helmetflag = false;
          });
        }
        if (flags[0].helmetStatus as int == 1) {
          setState(() {
            helmetflag = true;
          });
        }

        if (flags[0].rfidStatus as int == 0) {
          setState(() {
            rfidflag = false;
          });
        }
        if (flags[0].rfidStatus as int == 1) {
          setState(() {
            rfidflag = true;
          });
        }

        if (flags[0].defaultVtype as int == 0) {
          setState(() {
            defaultEnabled = false;
          });
        }
        if (flags[0].defaultVtype as int == 1) {
          setState(() {
            defaultEnabled = true;
          });
        }
      }
    } catch (Exception) {}
    print(rfidflag);
    print(defaultEnabled);
    print(helmetflag);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
