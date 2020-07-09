// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<UserMasterMO> userMasterFromJson(String str) => List<UserMasterMO>.from(json.decode(str).map((x) => UserMasterMO.fromJson(x)));

String userMasterToJson(List<UserMasterMO> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserMasterMO {
  UserMasterMO({
    this.userId,
    this.userName,
    this.userPhone,
    this.userStatus,
    this.userType,
    this.userPass,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
  });

  String userId;
  String userName;
  String userPhone;
  String userStatus;
  String userType;
  String userPass;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;

  factory UserMasterMO.fromJson(Map<String, dynamic> json) => UserMasterMO(
    userId: json["user_id"],
    userName: json["user_name"],
    userPhone: json["user_phone"],
    userStatus: json["user_status"],
    userType: json["user_type"],
    userPass: json["user_pass"],
    createdOn: DateTime.parse(json["created_on"]),
    createdBy: json["created_by"],
    modifiedOn: DateTime.parse(json["modified_on"]),
    modifiedBy: json["modified_by"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "user_phone": userPhone,
    "user_status": userStatus,
    "user_type": userType,
    "user_pass": userPass,
    "created_on": createdOn.toIso8601String(),
    "created_by": createdBy,
    "modified_on": modifiedOn.toIso8601String(),
    "modified_by": modifiedBy,
  };
}
