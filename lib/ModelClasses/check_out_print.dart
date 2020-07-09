// To parse this JSON data, do
//
//     final checkOutPrint = checkOutPrintFromJson(jsonString);

import 'dart:convert';

List<CheckOutPrint> checkOutPrintFromJson(String str) =>
    List<CheckOutPrint>.from(
        json.decode(str).map((x) => CheckOutPrint.fromJson(x)));

String checkOutPrintToJson(List<CheckOutPrint> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckOutPrint {
  CheckOutPrint({
    this.transactionId,
    this.vehicleNumber,
    this.vehicleType,
    this.checkinTime,
    this.checkoutTime,
    this.totalTime,
    this.grandTotal,
  });

  String transactionId;
  String vehicleNumber;
  String vehicleType;
  DateTime checkinTime;
  DateTime checkoutTime;
  String totalTime;
  String grandTotal;

  factory CheckOutPrint.fromJson(Map<String, dynamic> json) => CheckOutPrint(
        transactionId: json["transaction_id"],
        vehicleNumber: json["vehicle_number"],
        vehicleType: json["vehicle_type"],
        checkinTime: DateTime.parse(json["checkin_time"]),
        checkoutTime: DateTime.parse(json["checkout_time"]),
        totalTime: json["total_time"],
        grandTotal: json["grand_total"],
      );

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "vehicle_number": vehicleNumber,
        "vehicle_type": vehicleType,
        "checkin_time": checkinTime.toIso8601String(),
        "checkout_time": checkoutTime.toIso8601String(),
        "total_time": totalTime,
        "grand_total": grandTotal,
      };
}
