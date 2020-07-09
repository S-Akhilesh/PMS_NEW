// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<FlagMO> FlagMOFromJson(String str) => List<FlagMO>.from(json.decode(str).map((x) => FlagMO.fromJson(x)));

String FlagMOToJson(List<FlagMO> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FlagMO {
  FlagMO({
    this.prefixId,
    this.prefixValue,
    this.userId,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
    this.bufferTime,
    this.rfidStatus,
    this.helmetStatus,
    this.defaultVtype,
    this.financialEndDate,
    this.taxType,
  });

  String prefixId;
  String prefixValue;
  dynamic userId;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;
  String bufferTime;
  String rfidStatus;
  String helmetStatus;
  String defaultVtype;
  DateTime financialEndDate;
  String taxType;

  factory FlagMO.fromJson(Map<String, dynamic> json) => FlagMO(
    prefixId: json["prefix_id"],
    prefixValue: json["prefix_value"],
    userId: json["user_id"],
    createdOn: DateTime.parse(json["created_on"]),
    createdBy: json["created_by"],
    modifiedOn: DateTime.parse(json["modified_on"]),
    modifiedBy: json["modified_by"],
    bufferTime: json["buffer_time"],
    rfidStatus: json["rfid_status"],
    helmetStatus: json["helmet_status"],
    defaultVtype: json["default_vtype"],
    financialEndDate: DateTime.parse(json["financial_end_date"]),
    taxType: json["tax_type"],
  );

  Map<String, dynamic> toJson() => {
    "prefix_id": prefixId,
    "prefix_value": prefixValue,
    "user_id": userId,
    "created_on": createdOn.toIso8601String(),
    "created_by": createdBy,
    "modified_on": modifiedOn.toIso8601String(),
    "modified_by": modifiedBy,
    "buffer_time": bufferTime,
    "rfid_status": rfidStatus,
    "helmet_status": helmetStatus,
    "default_vtype": defaultVtype,
    "financial_end_date": "${financialEndDate.year.toString().padLeft(4, '0')}-${financialEndDate.month.toString().padLeft(2, '0')}-${financialEndDate.day.toString().padLeft(2, '0')}",
    "tax_type": taxType,
  };
}
