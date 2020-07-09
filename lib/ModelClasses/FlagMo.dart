// To parse this JSON data, do
//
//     final flagMo = flagMoFromJson(jsonString);

import 'dart:convert';

List<FlagMo> flagMoFromJson(String str) => List<FlagMo>.from(json.decode(str).map((x) => FlagMo.fromJson(x)));

String flagMoToJson(List<FlagMo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FlagMo {
  FlagMo({
    this.rfidStatus,
    this.helmetStatus,
    this.defaultVtype,
  });

  String rfidStatus;
  String helmetStatus;
  String defaultVtype;

  factory FlagMo.fromJson(Map<String, dynamic> json) => FlagMo(
    rfidStatus: json["rfid_status"],
    helmetStatus: json["helmet_status"],
    defaultVtype: json["default_vtype"],
  );

  Map<String, dynamic> toJson() => {
    "rfid_status": rfidStatus,
    "helmet_status": helmetStatus,
    "default_vtype": defaultVtype,
  };
}
