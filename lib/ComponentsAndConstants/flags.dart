import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pms/ModelClasses/FlagMo.dart';


bool bikeSelectedFlag = false,
    defaultEnabled = false,
    rfidflag = true,
    helmetflag = true,
    isTax = false,
    isConnected = false;

String host = '192.168.0.123'; // setting Wifi Printer Host in Admin Panel
String url;

var flags = new List<FlagMO>();


Future<void> fetchFlag() async{
  var response = await http.post(
      'http://192.168.43.196/www/NEW/Flag.php');
  try {
    if (response.statusCode == 200) {
      print("Inside");
      var flagJson = json.decode(response.body);
      print(flagJson);
      for (var flag in flagJson) {
        flags.insert(0, FlagMO.fromJson(flag));
      }

      print("Inside");
      if(flags[0].helmetStatus as int == 0){
        helmetflag = false;
      }
      if(flags[0].helmetStatus as int == 1){
        helmetflag = true;
      }

      if(flags[0].rfidStatus as int == 0){
        rfidflag = false;
      }
      if(flags[0].rfidStatus as int == 1){
        rfidflag = true;
      }


      if(flags[0].defaultVtype as int == 0){
        defaultEnabled = false;
      }
      if(flags[0].defaultVtype as int == 1){
        defaultEnabled = true;
      }

    }
  } catch (Exception) {}
}