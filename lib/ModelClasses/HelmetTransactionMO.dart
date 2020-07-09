// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<HelmetTransactionMO> helmetTransactionFromJson(String str) => List<HelmetTransactionMO>.from(json.decode(str).map((x) => HelmetTransactionMO.fromJson(x)));

String helmetTransactionToJson(List<HelmetTransactionMO> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HelmetTransactionMO {
  HelmetTransactionMO({
    this.id,
    this.ticketNumber,
    this.sgstPercent,
    this.sgstAmount,
    this.cgstPercent,
    this.cgstAmount,
    this.priMiscPercent,
    this.priMiscAmount,
    this.secMiscPercent,
    this.secMiscAmount,
    this.totalTax,
    this.netAmount,
    this.grandTotal,
  });

  String id;
  String ticketNumber;
  String sgstPercent;
  String sgstAmount;
  String cgstPercent;
  String cgstAmount;
  String priMiscPercent;
  String priMiscAmount;
  String secMiscPercent;
  String secMiscAmount;
  String totalTax;
  String netAmount;
  String grandTotal;

  factory HelmetTransactionMO.fromJson(Map<String, dynamic> json) => HelmetTransactionMO(
    id: json["id"],
    ticketNumber: json["ticket_number"],
    sgstPercent: json["sgst_percent"],
    sgstAmount: json["sgst_amount"],
    cgstPercent: json["cgst_percent"],
    cgstAmount: json["cgst_amount"],
    priMiscPercent: json["pri_misc_percent"],
    priMiscAmount: json["pri_misc_amount"],
    secMiscPercent: json["sec_misc_percent"],
    secMiscAmount: json["sec_misc_amount"],
    totalTax: json["total_tax"],
    netAmount: json["net_amount"],
    grandTotal: json["grand_total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticket_number": ticketNumber,
    "sgst_percent": sgstPercent,
    "sgst_amount": sgstAmount,
    "cgst_percent": cgstPercent,
    "cgst_amount": cgstAmount,
    "pri_misc_percent": priMiscPercent,
    "pri_misc_amount": priMiscAmount,
    "sec_misc_percent": secMiscPercent,
    "sec_misc_amount": secMiscAmount,
    "total_tax": totalTax,
    "net_amount": netAmount,
    "grand_total": grandTotal,
  };
}
