import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    this.vehicleType,
  });

  String vehicleType;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        vehicleType: json["vehicle_type"],
      );

  Map<String, dynamic> toJson() => {
        "vehicle_type": vehicleType,
      };
}
