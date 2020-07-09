// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<TaxMasterMO> taxMasterFromJson(String str) => List<TaxMasterMO>.from(json.decode(str).map((x) => TaxMasterMO.fromJson(x)));

String taxMAsterToJson(List<TaxMasterMO> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaxMasterMO {
  TaxMasterMO({
    this.taxId,
    this.taxName,
    this.taxValue,
    this.sgstValue,
    this.cgstValue,
    this.priMiscLabel,
    this.priMiscValue,
    this.secMiscLabel,
    this.secMiscValue,
    this.taxStatus,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
  });

  String taxId;
  String taxName;
  String taxValue;
  String sgstValue;
  String cgstValue;
  String priMiscLabel;
  String priMiscValue;
  String secMiscLabel;
  String secMiscValue;
  String taxStatus;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;

  factory TaxMasterMO.fromJson(Map<String, dynamic> json) => TaxMasterMO(
    taxId: json["tax_id"],
    taxName: json["tax_name"],
    taxValue: json["tax_value"],
    sgstValue: json["sgst_value"],
    cgstValue: json["cgst_value"],
    priMiscLabel: json["pri_misc_label"],
    priMiscValue: json["pri_misc_value"],
    secMiscLabel: json["sec_misc_label"],
    secMiscValue: json["sec_misc_value"],
    taxStatus: json["tax_status"],
    createdOn: DateTime.parse(json["created_on"]),
    createdBy: json["created_by"],
    modifiedOn: DateTime.parse(json["modified_on"]),
    modifiedBy: json["modified_by"],
  );

  Map<String, dynamic> toJson() => {
    "tax_id": taxId,
    "tax_name": taxName,
    "tax_value": taxValue,
    "sgst_value": sgstValue,
    "cgst_value": cgstValue,
    "pri_misc_label": priMiscLabel,
    "pri_misc_value": priMiscValue,
    "sec_misc_label": secMiscLabel,
    "sec_misc_value": secMiscValue,
    "tax_status": taxStatus,
    "created_on": createdOn.toIso8601String(),
    "created_by": createdBy,
    "modified_on": modifiedOn.toIso8601String(),
    "modified_by": modifiedBy,
  };
}
