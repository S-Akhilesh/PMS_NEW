// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<TransactionMO> transactionFromJson(String str) => List<TransactionMO>.from(json.decode(str).map((x) => TransactionMO.fromJson(x)));

String transactionToJson(List<TransactionMO> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionMO {
  TransactionMO({
    this.transactionId,
    this.vehicleNumber,
    this.ticketNumber,
    this.rfid,
    this.alternateId,
    this.checkinType,
    this.vehicleType,
    this.helmetCount,
    this.checkinTime,
    this.checkoutTime,
    this.totalTime,
    this.sgstPercent,
    this.sgstAmount,
    this.cgstPercent,
    this.cgstAmount,
    this.priMiscValue,
    this.priMiscAmount,
    this.secMiscValue,
    this.secMiscAmount,
    this.totalTax,
    this.netAmount,
    this.grandTotal,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
  });

  String transactionId;
  String vehicleNumber;
  String ticketNumber;
  String rfid;
  String alternateId;
  String checkinType;
  String vehicleType;
  String helmetCount;
  DateTime checkinTime;
  DateTime checkoutTime;
  String totalTime;
  String sgstPercent;
  String sgstAmount;
  String cgstPercent;
  String cgstAmount;
  String priMiscValue;
  String priMiscAmount;
  String secMiscValue;
  String secMiscAmount;
  String totalTax;
  String netAmount;
  String grandTotal;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;

  factory TransactionMO.fromJson(Map<String, dynamic> json) => TransactionMO(
    transactionId: json["transaction_id"],
    vehicleNumber: json["vehicle_number"],
    ticketNumber: json["ticket_number"],
    rfid: json["rfid"],
    alternateId: json["alternate_id"],
    checkinType: json["checkin_type"],
    vehicleType: json["vehicle_type"],
    helmetCount: json["helmet_count"],
    checkinTime: DateTime.parse(json["checkin_time"]),
    checkoutTime: DateTime.parse(json["checkout_time"]),
    totalTime: json["total_time"],
    sgstPercent: json["sgst_percent"],
    sgstAmount: json["sgst_amount"],
    cgstPercent: json["cgst_percent"],
    cgstAmount: json["cgst_amount"],
    priMiscValue: json["pri_misc_value"],
    priMiscAmount: json["pri_misc_amount"],
    secMiscValue: json["sec_misc_value"],
    secMiscAmount: json["sec_misc_amount"],
    totalTax: json["total_tax"],
    netAmount: json["net_amount"],
    grandTotal: json["grand_total"],
    createdOn: DateTime.parse(json["created_on"]),
    createdBy: json["created_by"],
    modifiedOn: DateTime.parse(json["modified_on"]),
    modifiedBy: json["modified_by"],
  );

  Map<String, dynamic> toJson() => {
    "transaction_id": transactionId,
    "vehicle_number": vehicleNumber,
    "ticket_number": ticketNumber,
    "rfid": rfid,
    "alternate_id": alternateId,
    "checkin_type": checkinType,
    "vehicle_type": vehicleType,
    "helmet_count": helmetCount,
    "checkin_time": checkinTime.toIso8601String(),
    "checkout_time": checkoutTime.toIso8601String(),
    "total_time": totalTime,
    "sgst_percent": sgstPercent,
    "sgst_amount": sgstAmount,
    "cgst_percent": cgstPercent,
    "cgst_amount": cgstAmount,
    "pri_misc_value": priMiscValue,
    "pri_misc_amount": priMiscAmount,
    "sec_misc_value": secMiscValue,
    "sec_misc_amount": secMiscAmount,
    "total_tax": totalTax,
    "net_amount": netAmount,
    "grand_total": grandTotal,
    "created_on": createdOn.toIso8601String(),
    "created_by": createdBy,
    "modified_on": modifiedOn.toIso8601String(),
    "modified_by": modifiedBy,
  };
}
