// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<PassMO> passFromJson(String str) => List<PassMO>.from(json.decode(str).map((x) => PassMO.fromJson(x)));

String passToJson(List<PassMO> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PassMO {
  PassMO({
    this.passId,
    this.passPlan,
    this.passFrom,
    this.passTo,
    this.rfid,
    this.alternateNumber,
    this.amount,
    this.taxPercent,
    this.passStatus,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
  });

  String passId;
  String passPlan;
  DateTime passFrom;
  DateTime passTo;
  String rfid;
  String alternateNumber;
  String amount;
  String taxPercent;
  String passStatus;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;

  factory PassMO.fromJson(Map<String, dynamic> json) => PassMO(
    passId: json["pass_id"],
    passPlan: json["pass_plan"],
    passFrom: DateTime.parse(json["pass_from"]),
    passTo: DateTime.parse(json["pass_to"]),
    rfid: json["rfid"],
    alternateNumber: json["alternate_number"],
    amount: json["amount"],
    taxPercent: json["tax_percent"],
    passStatus: json["pass_status"],
    createdOn: DateTime.parse(json["created_on"]),
    createdBy: json["created_by"],
    modifiedOn: DateTime.parse(json["modified_on"]),
    modifiedBy: json["modified_by"],
  );

  Map<String, dynamic> toJson() => {
    "pass_id": passId,
    "pass_plan": passPlan,
    "pass_from": "${passFrom.year.toString().padLeft(4, '0')}-${passFrom.month.toString().padLeft(2, '0')}-${passFrom.day.toString().padLeft(2, '0')}",
    "pass_to": "${passTo.year.toString().padLeft(4, '0')}-${passTo.month.toString().padLeft(2, '0')}-${passTo.day.toString().padLeft(2, '0')}",
    "rfid": rfid,
    "alternate_number": alternateNumber,
    "amount": amount,
    "tax_percent": taxPercent,
    "pass_status": passStatus,
    "created_on": createdOn.toIso8601String(),
    "created_by": createdBy,
    "modified_on": modifiedOn.toIso8601String(),
    "modified_by": modifiedBy,
  };
}
