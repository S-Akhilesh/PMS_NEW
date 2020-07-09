// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<TagMasterMO> tagMasterFromJson(String str) => List<TagMasterMO>.from(json.decode(str).map((x) => TagMasterMO.fromJson(x)));

String tagMasterToJson(List<TagMasterMO> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TagMasterMO {
  TagMasterMO({
    this.id,
    this.rfid,
    this.alternateNumber,
    this.tagNumber,
    this.tagStatus,
    this.assignedStatus,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
  });

  String id;
  String rfid;
  String alternateNumber;
  String tagNumber;
  String tagStatus;
  String assignedStatus;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;

  factory TagMasterMO.fromJson(Map<String, dynamic> json) => TagMasterMO(
    id: json["id"],
    rfid: json["rfid"] == null ? null : json["rfid"],
    alternateNumber: json["alternate_number"] == null ? null : json["alternate_number"],
    tagNumber: json["tag_number"],
    tagStatus: json["tag_status"],
    assignedStatus: json["assigned_status"],
    createdOn: DateTime.parse(json["created_on"]),
    createdBy: json["created_by"],
    modifiedOn: DateTime.parse(json["modified_on"]),
    modifiedBy: json["modified_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rfid": rfid == null ? null : rfid,
    "alternate_number": alternateNumber == null ? null : alternateNumber,
    "tag_number": tagNumber,
    "tag_status": tagStatus,
    "assigned_status": assignedStatus,
    "created_on": createdOn.toIso8601String(),
    "created_by": createdBy,
    "modified_on": modifiedOn.toIso8601String(),
    "modified_by": modifiedBy,
  };
}
