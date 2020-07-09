// To parse this JSON data, do
//
//     final checkInPrint = checkInPrintFromJson(jsonString);

import 'dart:convert';

List<CheckInPrint> checkInPrintFromJson(String str) => List<CheckInPrint>.from(
    json.decode(str).map((x) => CheckInPrint.fromJson(x)));

String checkInPrintToJson(List<CheckInPrint> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckInPrint {
  CheckInPrint({
    this.transactionId,
    this.vehicleNumber,
    this.vehicleType,
    this.checkinTime,
    this.organizationName,
    this.phonenumber,
    this.email,
    this.address,
  });

  String transactionId;
  String vehicleNumber;
  String vehicleType;
  DateTime checkinTime;
  String organizationName;
  String phonenumber;
  String email;
  String address;

  factory CheckInPrint.fromJson(Map<String, dynamic> json) => CheckInPrint(
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        vehicleNumber:
            json["vehicle_number"] == null ? null : json["vehicle_number"],
        vehicleType: json["vehicle_type"] == null ? null : json["vehicle_type"],
        checkinTime: json["checkin_time"] == null
            ? null
            : DateTime.parse(json["checkin_time"]),
        organizationName: json["organization_name"] == null
            ? null
            : json["organization_name"],
        phonenumber: json["phonenumber"] == null ? null : json["phonenumber"],
        email: json["email"] == null ? null : json["email"],
        address: json["address"] == null ? null : json["address"],
      );

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId == null ? null : transactionId,
        "vehicle_number": vehicleNumber == null ? null : vehicleNumber,
        "vehicle_type": vehicleType == null ? null : vehicleType,
        "checkin_time":
            checkinTime == null ? null : checkinTime.toIso8601String(),
        "organization_name": organizationName == null ? null : organizationName,
        "phonenumber": phonenumber == null ? null : phonenumber,
        "email": email == null ? null : email,
        "address": address == null ? null : address,
      };
}
