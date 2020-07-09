// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<VehiclaMasterMO> vehicleMasterFromJson(String str) => List<VehiclaMasterMO>.from(json.decode(str).map((x) => VehiclaMasterMO.fromJson(x)));

String vehicleMasterToJson(List<VehiclaMasterMO> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VehiclaMasterMO {
  VehiclaMasterMO({
    this.vehicleId,
    this.vehicleType,
    this.accessKey,
    this.taxApplicable,
    this.vehicleStatus,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
  });

  String vehicleId;
  String vehicleType;
  String accessKey;
  String taxApplicable;
  String vehicleStatus;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;

  factory VehiclaMasterMO.fromJson(Map<String, dynamic> json) => VehiclaMasterMO(
    vehicleId: json["vehicle_id"],
    vehicleType: json["vehicle_type"],
    accessKey: json["access_key"],
    taxApplicable: json["tax_applicable"],
    vehicleStatus: json["vehicle_status"],
    createdOn: DateTime.parse(json["created_on"]),
    createdBy: json["created_by"],
    modifiedOn: DateTime.parse(json["modified_on"]),
    modifiedBy: json["modified_by"],
  );

  Map<String, dynamic> toJson() => {
    "vehicle_id": vehicleId,
    "vehicle_type": vehicleType,
    "access_key": accessKey,
    "tax_applicable": taxApplicable,
    "vehicle_status": vehicleStatus,
    "created_on": createdOn.toIso8601String(),
    "created_by": createdBy,
    "modified_on": modifiedOn.toIso8601String(),
    "modified_by": modifiedBy,
  };
}
