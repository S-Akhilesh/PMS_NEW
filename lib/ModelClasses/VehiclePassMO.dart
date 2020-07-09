// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<VehiclePassMO> welcomeFromJson(String str) => List<VehiclePassMO>.from(json.decode(str).map((x) => VehiclePassMO.fromJson(x)));

String welcomeToJson(List<VehiclePassMO> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VehiclePassMO {
  VehiclePassMO({
    this.vehiclePassId,
    this.vehicleNumber,
    this.passId,
    this.amount,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
  });

  String vehiclePassId;
  String vehicleNumber;
  String passId;
  String amount;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;

  factory VehiclePassMO.fromJson(Map<String, dynamic> json) => VehiclePassMO(
    vehiclePassId: json["vehicle_pass_id"],
    vehicleNumber: json["vehicle_number"],
    passId: json["pass_id"],
    amount: json["amount"],
    createdOn: DateTime.parse(json["created_on"]),
    createdBy: json["created_by"],
    modifiedOn: DateTime.parse(json["modified_on"]),
    modifiedBy: json["modified_by"],
  );

  Map<String, dynamic> toJson() => {
    "vehicle_pass_id": vehiclePassId,
    "vehicle_number": vehicleNumber,
    "pass_id": passId,
    "amount": amount,
    "created_on": "${createdOn.year.toString().padLeft(4, '0')}-${createdOn.month.toString().padLeft(2, '0')}-${createdOn.day.toString().padLeft(2, '0')}",
    "created_by": createdBy,
    "modified_on": "${modifiedOn.year.toString().padLeft(4, '0')}-${modifiedOn.month.toString().padLeft(2, '0')}-${modifiedOn.day.toString().padLeft(2, '0')}",
    "modified_by": modifiedBy,
  };
}
