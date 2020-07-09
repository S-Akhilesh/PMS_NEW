// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<VehicleTaxMO> vehicleTaxFromJson(String str) => List<VehicleTaxMO>.from(json.decode(str).map((x) => VehicleTaxMO.fromJson(x)));

String vehicleTaxToJson(List<VehicleTaxMO> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VehicleTaxMO {
  VehicleTaxMO({
    this.vehicleId,
    this.taxId,
    this.taxPercent,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
    this.status,
  });

  String vehicleId;
  String taxId;
  String taxPercent;
  String createdOn;
  String createdBy;
  String modifiedOn;
  String modifiedBy;
  String status;

  factory VehicleTaxMO.fromJson(Map<String, dynamic> json) => VehicleTaxMO(
    vehicleId: json["vehicle_id"],
    taxId: json["tax_id"],
    taxPercent: json["tax_percent"],
    createdOn: json["created_on"],
    createdBy: json["created_by"],
    modifiedOn: json["modified_on"],
    modifiedBy: json["modified_by"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "vehicle_id": vehicleId,
    "tax_id": taxId,
    "tax_percent": taxPercent,
    "created_on": createdOn,
    "created_by": createdBy,
    "modified_on": modifiedOn,
    "modified_by": modifiedBy,
    "status": status,
  };
}
