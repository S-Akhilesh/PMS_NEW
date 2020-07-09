import 'dart:async';
import 'dart:convert';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pms/ComponentsAndConstants/flags.dart';
import 'package:pms/ModelClasses/check_in_print.dart';
import 'package:pms/ModelClasses/check_out_print2.dart';

class BluetoothPrint extends StatefulWidget {
  @override
  _BluetoothPrintState createState() => _BluetoothPrintState();
}

class _BluetoothPrintState extends State<BluetoothPrint> {
  String organistion,
      receiptno,
      vechiletype,
      vehcilenumber,
      indate,
      phnumber,
      email,
      address;
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  bool _loading = false;
  var t_table = List<CheckInPrint>();
  var o_table = List<CheckOutPrint2>();
  @override
  void initState() {
    _loading = true;
    fetchDetails();
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

                  bluetoothPrint(position);
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

  List<int> returnTid(String source) {
    int size = source.length;
    List<int> tid = new List();
    int temp;
    for (int i = 0; i <= size - 1; i++) {
      temp = int.parse(source[i]);
      print(temp);
      tid.add(temp);
    }
    return tid;
  }

  bluetoothPrint(position) {
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
        text: 'IN DATE: $indate',
        width: 12,
        styles:
            PosStyles(align: PosTextAlign.left, underline: false, bold: true),
      ),
    ]);
    ticket.emptyLines(2);
    final List<dynamic> barData = returnTid("$receiptno");
    ticket.barcode(Barcode.code39(barData));
    ticket.feed(1);
    ticket.cut();
    printerManager.printTicket(ticket).then((result) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(result.msg)));
    }).catchError((error) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  Future<void> fetchDetails() async {
    var response = await http.post('http://$url/www/NEW/BluetoothAPI.php');
    var response2 = await http.post('http://$url/www/NEW/BluetoothAPI2.php');

    try {
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var jsonResponse2 = json.decode(response2.body);

        for (var types in jsonResponse) {
          receiptno = (CheckInPrint.fromJson(types).transactionId);
          vechiletype = (CheckInPrint.fromJson(types).vehicleType);
          vehcilenumber = (CheckInPrint.fromJson(types).vehicleNumber);
          indate = (CheckInPrint.fromJson(types).checkinTime.toIso8601String());
        }
        for (var types in jsonResponse2) {
          organistion =
              (CheckInPrint.fromJson(types).organizationName.toUpperCase());

          phnumber = (CheckInPrint.fromJson(types).phonenumber);
          email = (CheckInPrint.fromJson(types).email);
          address = (CheckInPrint.fromJson(types).address);
        }

        print(receiptno);
      }
    } catch (Exception) {
      print("GOthilla");
    }
    setState(() {
      _loading = false;
    });
  }
}
