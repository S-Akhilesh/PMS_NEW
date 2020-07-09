// To parse this JSON data, do
//
//     final checkInPrint = checkInPrintFromJson(jsonString);

import 'dart:convert';

List<CheckOutPrint2> checkOutPrint2FromJson(String str) =>
    List<CheckOutPrint2>.from(
        json.decode(str).map((x) => CheckOutPrint2.fromJson(x)));

String checkOutPrint2ToJson(List<CheckOutPrint2> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckOutPrint2 {
  CheckOutPrint2({
    this.organizationName,
    this.phonenumber,
    this.email,
    this.address,
  });

  String organizationName;
  String phonenumber;
  String email;
  String address;

  factory CheckOutPrint2.fromJson(Map<String, dynamic> json) => CheckOutPrint2(
        organizationName: json["organization_name"],
        phonenumber: json["phonenumber"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "organization_name": organizationName,
        "phonenumber": phonenumber,
        "email": email,
        "address": address,
      };
}
