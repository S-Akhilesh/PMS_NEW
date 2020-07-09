import 'VehiclePassMO.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

Future<List<VehiclePassMO>> fetchProducts() async{

  String url ="http://192.168.43.196/www/PHP/VehiclePass.php";
  final response = await http.get(url);
  return welcomeFromJson(response.body);
}