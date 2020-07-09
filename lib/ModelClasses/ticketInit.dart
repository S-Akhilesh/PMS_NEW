import 'dart:convert';

List<TicketInit> welcomeFromJson(String str) =>
    List<TicketInit>.from(json.decode(str).map((x) => TicketInit.fromJson(x)));

String welcomeToJson(List<TicketInit> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketInit {
  TicketInit({
    this.ticketNumber,
  });

  String ticketNumber;

  factory TicketInit.fromJson(Map<String, dynamic> json) => TicketInit(
        ticketNumber: json["ticket_number"],
      );

  Map<String, dynamic> toJson() => {
        "ticket_number": ticketNumber,
      };
}
