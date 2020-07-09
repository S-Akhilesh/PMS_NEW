// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<OrgnizationMasterMO> orgnizationMasterFromJson(String str) => List<OrgnizationMasterMO>.from(json.decode(str).map((x) => OrgnizationMasterMO.fromJson(x)));

String orgnizationMasterToJson(List<OrgnizationMasterMO> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrgnizationMasterMO {
  OrgnizationMasterMO({
    this.orgnizationId,
    this.organizationName,
    this.phonenumber,
    this.email,
    this.address,
    this.gstinNumber,
    this.contactperson,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
  });

  String orgnizationId;
  String organizationName;
  String phonenumber;
  String email;
  String address;
  String gstinNumber;
  String contactperson;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;

  factory OrgnizationMasterMO.fromJson(Map<String, dynamic> json) => OrgnizationMasterMO(
    orgnizationId: json["orgnization_id"],
    organizationName: json["organization_name"],
    phonenumber: json["phonenumber"],
    email: json["email"],
    address: json["address"],
    gstinNumber: json["gstin_number"],
    contactperson: json["contactperson"],
    createdOn: DateTime.parse(json["created_on"]),
    createdBy: json["created_by"],
    modifiedOn: DateTime.parse(json["modified_on"]),
    modifiedBy: json["modified_by"],
  );

  Map<String, dynamic> toJson() => {
    "orgnization_id": orgnizationId,
    "organization_name": organizationName,
    "phonenumber": phonenumber,
    "email": email,
    "address": address,
    "gstin_number": gstinNumber,
    "contactperson": contactperson,
    "created_on": "${createdOn.year.toString().padLeft(4, '0')}-${createdOn.month.toString().padLeft(2, '0')}-${createdOn.day.toString().padLeft(2, '0')}",
    "created_by": createdBy,
    "modified_on": "${modifiedOn.year.toString().padLeft(4, '0')}-${modifiedOn.month.toString().padLeft(2, '0')}-${modifiedOn.day.toString().padLeft(2, '0')}",
    "modified_by": modifiedBy,
  };
}
