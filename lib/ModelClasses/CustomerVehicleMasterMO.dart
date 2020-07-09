// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> customerVehicleFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String customerVehicleToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    this.vehicleId,
    this.customerId,
    this.vehicleNumber,
    this.vehicleType,
    this.vehicleName,
    this.vehicleStatus,
    this.passAssignedStatus,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
  });

  String vehicleId;
  String customerId;
  String vehicleNumber;
  String vehicleType;
  String vehicleName;
  String vehicleStatus;
  String passAssignedStatus;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    vehicleId: json["vehicle_id"],
    customerId: json["customer_id"],
    vehicleNumber: json["vehicle_number"],
    vehicleType: json["vehicle_type"],
    vehicleName: json["vehicle_name"],
    vehicleStatus: json["vehicle_status"],
    passAssignedStatus: json["pass_assigned_status"],
    createdOn: DateTime.parse(json["created_on"]),
    createdBy: json["created_by"],
    modifiedOn: DateTime.parse(json["modified_on"]),
    modifiedBy: json["modified_by"],
  );

  Map<String, dynamic> toJson() => {
    "vehicle_id": vehicleId,
    "customer_id": customerId,
    "vehicle_number": vehicleNumber,
    "vehicle_type": vehicleType,
    "vehicle_name": vehicleName,
    "vehicle_status": vehicleStatus,
    "pass_assigned_status": passAssignedStatus,
    "created_on": "${createdOn.year.toString().padLeft(4, '0')}-${createdOn.month.toString().padLeft(2, '0')}-${createdOn.day.toString().padLeft(2, '0')}",
    "created_by": createdBy,
    "modified_on": "${modifiedOn.year.toString().padLeft(4, '0')}-${modifiedOn.month.toString().padLeft(2, '0')}-${modifiedOn.day.toString().padLeft(2, '0')}",
    "modified_by": modifiedBy,
  };
}
