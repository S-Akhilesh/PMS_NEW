// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<SlabMasterMo> slabMasterFromJson(String str) => List<SlabMasterMo>.from(json.decode(str).map((x) => SlabMasterMo.fromJson(x)));

String slabMasterToJson(List<SlabMasterMo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SlabMasterMo {
  SlabMasterMo({
    this.slabId,
    this.slabName,
    this.slabType,
    this.vehicleType,
    this.fromTime,
    this.toTime,
    this.amount,
    this.slabStatus,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
  });

  String slabId;
  String slabName;
  SlabType slabType;
  VehicleType vehicleType;
  String fromTime;
  String toTime;
  String amount;
  SlabStatus slabStatus;
  DateTime createdOn;
  EdBy createdBy;
  DateTime modifiedOn;
  EdBy modifiedBy;

  factory SlabMasterMo.fromJson(Map<String, dynamic> json) => SlabMasterMo(
    slabId: json["slab_id"],
    slabName: json["slab_name"],
    slabType: slabTypeValues.map[json["slab_type"]],
    vehicleType: vehicleTypeValues.map[json["vehicle_type"]],
    fromTime: json["from_time"],
    toTime: json["to_time"],
    amount: json["amount"],
    slabStatus: slabStatusValues.map[json["slab_status"]],
    createdOn: DateTime.parse(json["created_on"]),
    createdBy: edByValues.map[json["created_by"]],
    modifiedOn: DateTime.parse(json["modified_on"]),
    modifiedBy: edByValues.map[json["modified_by"]],
  );

  Map<String, dynamic> toJson() => {
    "slab_id": slabId,
    "slab_name": slabName,
    "slab_type": slabTypeValues.reverse[slabType],
    "vehicle_type": vehicleTypeValues.reverse[vehicleType],
    "from_time": fromTime,
    "to_time": toTime,
    "amount": amount,
    "slab_status": slabStatusValues.reverse[slabStatus],
    "created_on": createdOn.toIso8601String(),
    "created_by": edByValues.reverse[createdBy],
    "modified_on": modifiedOn.toIso8601String(),
    "modified_by": edByValues.reverse[modifiedBy],
  };
}

enum EdBy { USER, EMPTY, ADMIN }

final edByValues = EnumValues({
  "admin": EdBy.ADMIN,
  "": EdBy.EMPTY,
  "user": EdBy.USER
});

enum SlabStatus { ACTIVE }

final slabStatusValues = EnumValues({
  "Active": SlabStatus.ACTIVE
});

enum SlabType { TICKET, PASS }

final slabTypeValues = EnumValues({
  "Pass": SlabType.PASS,
  "Ticket": SlabType.TICKET
});

enum VehicleType { BIKE, CAR, BUS, HELMET }

final vehicleTypeValues = EnumValues({
  "bike": VehicleType.BIKE,
  "bus": VehicleType.BUS,
  "car": VehicleType.CAR,
  "helmet": VehicleType.HELMET
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
