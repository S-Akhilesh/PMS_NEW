import 'dart:async';
import 'dart:convert';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pms/ComponentsAndConstants/flags.dart';
import 'package:pms/ModelClasses/check_out_print.dart';
import 'package:pms/ModelClasses/check_out_print2.dart';
import 'package:pms/UserPages2.0/Methods/CoutFormFields.dart';

class BluetoothPrintCheckOut extends StatefulWidget {
  @override
  _BluetoothPrintCheckOutState createState() => _BluetoothPrintCheckOutState();
}

class _BluetoothPrintCheckOutState extends State<BluetoothPrintCheckOut> {
  String organistion,
      receiptno,
      vechiletype,
      vehcilenumber,
      indate,
      phnumber,
      email,
      address,
      duration,
      fee,
      ticketnumber,
      outdate;
  CoutWidgets Cout = new CoutWidgets();
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  bool _loading = false;
  @override
  void initState() {
    _loading = false;
    fetchDetailsOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3383CD),
        title: Text(
          'AVAILABLE PRINTERS',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _loading
          ? LinearProgressIndicator()
          : ListView.builder(
              itemBuilder: (context, position) => ListTile(
                onTap: () async {
                  //TODO: FETCH THE CALCULATED DETAILS OF THE TICKET AND PRINT

                  bluetoothPrintOut(position);
                },
                title: Text(_devices[position].name),
                subtitle: Text(_devices[position].address),
              ),
              itemCount: _devices.length,
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("SEARCH"),
        backgroundColor: Color(0xFF3383CD),
        onPressed: () {
          printerManager.startScan(Duration(seconds: 1));
          printerManager.scanResults.listen((scannedDevices) {
            setState(() {
              _devices = scannedDevices;
            });
          });
        },
        icon: Icon(Icons.search),
        splashColor: Colors.greenAccent,
      ),
    );
  }

  bluetoothPrintOut(position) {
    printerManager.selectPrinter(_devices[position]);
    Ticket ticket = Ticket(PaperSize.mm58);
    ticket.text('$organistion'.toUpperCase(),
        styles: PosStyles(
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          align: PosTextAlign.center,
          fontType: PosFontType.fontA,
          reverse: false,
          underline: true,
        ));
    ticket.row([
      PosColumn(
        text: 'PHONE NO: $phnumber',
        width: 12,
        styles:
            PosStyles(align: PosTextAlign.left, underline: true, bold: true),
      ),
    ]);
    ticket.row([
      PosColumn(
        text: 'Email: $email',
        width: 12,
        styles:
            PosStyles(align: PosTextAlign.left, underline: true, bold: true),
      ),
    ]);
    ticket.row([
      PosColumn(
        text: 'Address: $address',
        width: 12,
        styles:
            PosStyles(align: PosTextAlign.left, underline: true, bold: true),
      ),
    ]);
    ticket.emptyLines(1);
    ticket.row([
      PosColumn(
        text: '--------------------------------',
        width: 12,
        styles:
            PosStyles(align: PosTextAlign.left, underline: true, bold: true),
      ),
    ]);
    ticket.row([
      PosColumn(
        text: 'RECEIPT NO: $receiptno',
        width: 12,
        styles:
            PosStyles(align: PosTextAlign.left, underline: true, bold: true),
      ),
    ]);
    ticket.emptyLines(1);
    ticket.row([
      PosColumn(
        text: 'VEHICLE TYPE: $vechiletype',
        width: 12,
        styles:
            PosStyles(align: PosTextAlign.left, underline: false, bold: true),
      ),
    ]);
    ticket.emptyLines(1);
    ticket.row([
      PosColumn(
        text: 'VEHICLE NUMBER: $vehcilenumber',
        width: 12,
        styles:
            PosStyles(align: PosTextAlign.left, underline: false, bold: true),
      ),
    ]);
    ticket.emptyLines(1);
    ticket.row([
      PosColumn(
        text: 'OUT DATE: $outdate',
        width: 12,
        styles:
            PosStyles(align: PosTextAlign.left, underline: false, bold: true),
      ),
    ]);
    ticket.row([
      PosColumn(
        text: 'DURATION: $duration',
        width: 12,
        styles:
            PosStyles(align: PosTextAlign.left, underline: false, bold: true),
      ),
    ]);
    ticket.row([
      PosColumn(
        text: 'Grand Total: $fee',
        width: 12,
        styles: PosStyles(
          align: PosTextAlign.left,
          underline: false,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      ),
    ]);
    ticket.emptyLines(2);
    ticket.feed(1);
    ticket.cut();
    printerManager.printTicket(ticket).then((result) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(result.msg)));
    }).catchError((error) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  Future<void> fetchDetailsOut() async {
    Map data = {
      "ticket_number": Cout.ticketNumber,
    };
    print(data);
    var response =
        await http.post('http://$url/www/NEW/CheckOutPrint.php', body: data);
    var response2 = await http.post('http://$url/www/NEW/BluetoothAPI2.php');

    try {
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var jsonResponse2 = json.decode(response2.body);
        print(jsonResponse);
        print(jsonResponse2);
        for (var types in jsonResponse) {
          receiptno = (CheckOutPrint.fromJson(types).transactionId);
          vechiletype = (CheckOutPrint.fromJson(types).vehicleType);
          vehcilenumber = (CheckOutPrint.fromJson(types).vehicleNumber);
          indate =
              (CheckOutPrint.fromJson(types).checkinTime.toIso8601String());
          outdate =
              (CheckOutPrint.fromJson(types).checkinTime.toIso8601String());
          duration = (CheckOutPrint.fromJson(types).totalTime);
          fee = (CheckOutPrint.fromJson(types).grandTotal);
        }
        for (var types in jsonResponse2) {
          organistion =
              (CheckOutPrint2.fromJson(types).organizationName.toUpperCase());
          phnumber = (CheckOutPrint2.fromJson(types).phonenumber);
          email = (CheckOutPrint2.fromJson(types).email);
          address = (CheckOutPrint2.fromJson(types).address);
        }
//
//        print(receiptno);
      }
    } catch (Exception) {
      print("GOthilla");
    }

    setState(() {
      _loading = true;
    });
  }
}
