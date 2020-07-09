// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<CustomerMasterMo> customerMasterFromJson(String str) => List<CustomerMasterMo>.from(json.decode(str).map((x) => CustomerMasterMo.fromJson(x)));

String customerMasterToJson(List<CustomerMasterMo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerMasterMo {
  CustomerMasterMo({
    this.customerId,
    this.customerName,
    this.customerPhoto,
    this.phonenumber,
    this.customerDl,
    this.address,
    this.customerStatus,
    this.numberOfVehicles,
    this.numberVehiclesAllowed,
    this.orgnizationId,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
  });

  String customerId;
  String customerName;
  String customerPhoto;
  String phonenumber;
  String customerDl;
  String address;
  String customerStatus;
  String numberOfVehicles;
  String numberVehiclesAllowed;
  String orgnizationId;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;

  factory CustomerMasterMo.fromJson(Map<String, dynamic> json) => CustomerMasterMo(
    customerId: json["customer_id"],
    customerName: json["customer_name"],
    customerPhoto: json["customer_photo"],
    phonenumber: json["phonenumber"],
    customerDl: json["customer_dl"],
    address: json["address"],
    customerStatus: json["customer_status"],
    numberOfVehicles: json["number_of_vehicles"],
    numberVehiclesAllowed: json["number_vehicles_allowed"],
    orgnizationId: json["orgnization_id"],
    createdOn: DateTime.parse(json["created_on"]),
    createdBy: json["created_by"],
    modifiedOn: DateTime.parse(json["modified_on"]),
    modifiedBy: json["modified_by"],
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "customer_name": customerName,
    "customer_photo": customerPhoto,
    "phonenumber": phonenumber,
    "customer_dl": customerDl,
    "address": address,
    "customer_status": customerStatus,
    "number_of_vehicles": numberOfVehicles,
    "number_vehicles_allowed": numberVehiclesAllowed,
    "orgnization_id": orgnizationId,
    "created_on": createdOn.toIso8601String(),
    "created_by": createdBy,
    "modified_on": modifiedOn.toIso8601String(),
    "modified_by": modifiedBy,
  };
}
