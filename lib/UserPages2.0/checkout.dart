import 'dart:async';
import 'dart:convert';
//import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:pms/ModelClasses/ticketInit.dart';
import 'package:pms/Printing/bluetoothprintercheckout.dart';
import 'package:pms/login_page.dart';
import '../UserPages2.0/Methods/CoutFormFields.dart';
import '../ComponentsAndConstants/constants.dart';
import '../ComponentsAndConstants/flags.dart';
import 'package:http/http.dart' as http;

// ignore: non_constant_identifier_names
String Dupnumber = '';
String tabTNo = ' ', tabVno = " ", tabCost = " ";
bool alterNumber = false;

// ignore: camel_case_types
class nCheckout extends StatefulWidget {
  @override
  _nCheckoutState createState() => _nCheckoutState();
}

// ignore: camel_case_types
class _nCheckoutState extends State<nCheckout> {
  // ignore: non_constant_identifier_names
  String codeScanner;
  int groupValue = 1;
  String qrCodeResult = "SCAN TO KNOW THE QR RESULTS";
  String _rfidNumber = "Scan RFID Card";
  // ignore: non_constant_identifier_names
  TicketInit TicketNumberObject;
  // ignore: non_constant_identifier_names
  CoutWidgets CoutMethods = CoutWidgets();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  bool isprint = false, validated = false, ToggleSBVnumber = false;

  @override
  void initState() {
    tabTNo = ' ';
    tabVno = ' ';
    tabCost = ' ';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xFF3383CD).withOpacity(0.7),
          title: Text(
            "Check-out",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w300,
            ),
          )),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.search, color: Colors.black, size: 30),
                  Text(
                    "VEHICLE NUMBER",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 20.0,
                        letterSpacing: 2),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    height: 40.0,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: ToggleSBVnumber
                          ? Colors.greenAccent[100]
                          : Colors.redAccent[100].withOpacity(0.5),
                    ),
                    child: Stack(
                      children: <Widget>[
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.easeIn,
                          top: 3.0,
                          left: ToggleSBVnumber ? 60.0 : 0.0,
                          right: ToggleSBVnumber ? 0.0 : 60.0,
                          child: InkWell(
                            onTap: toggleVNButton,
                            child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 100),
                                // ignore: missing_return
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return RotationTransition(
                                    child: child,
                                    turns: animation,
                                  );
                                },
                                child: ToggleSBVnumber
                                    ? Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                        size: 35.0,
                                      )
                                    : Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red,
                                        size: 35.0,
                                      )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Visibility(
              visible: !ToggleSBVnumber,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Visibility(
                  visible: rfidflag,
                  child: FlatButton( //Expanded here
                    padding: EdgeInsets.only(
                        left: 120.0, right: 120.0, top: 15.0, bottom: 15.0),
                    onPressed: () {
                      setState(() {
                        getTicketNumberFromAlternateId(
                            CoutMethods.alternateNumber);
                        Stream<NDEFMessage> stream = NFC.readNDEF();
                        stream.listen((NDEFMessage message) {
                          _rfidNumber = message.data;
                        });
                      });
                    },
                    child: Center(
                      child: Text(
                        _rfidNumber,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.black.withOpacity(0.5), width: 3.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Visibility(
                    child: CoutMethods.buildVNumber(context),
                    visible: ToggleSBVnumber,
                  ),
                  Visibility(
                    child: CoutMethods.buildANumber(context),
                    visible: !ToggleSBVnumber,
                  ),
                  Visibility(
                    child: CoutMethods.buildticketNumber(context),
                    visible: !ToggleSBVnumber,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Visibility(
              visible: !ToggleSBVnumber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.print, color: Colors.black, size: 25),
                  Text(
                    "PRINT RECIEPT",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 20.0,
                        letterSpacing: 2),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    height: 40.0,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: isprint
                          ? Colors.greenAccent[100]
                          : Colors.redAccent[100].withOpacity(0.5),
                    ),
                    child: Stack(
                      children: <Widget>[
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.easeIn,
                          top: 3.0,
                          left: isprint ? 60.0 : 0.0,
                          right: isprint ? 0.0 : 60.0,
                          child: InkWell(
                            onTap: isprintToggled,
                            child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 100),
                                // ignore: missing_return
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return RotationTransition(
                                    child: child,
                                    turns: animation,
                                  );
                                },
                                child: isprint
                                    ? Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                        size: 35.0,
                                      )
                                    : Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red,
                                        size: 35.0,
                                      )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isprint & !ToggleSBVnumber,
              child: Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "WiFi Printer",
                        style: TextStyle(
                            letterSpacing: 2.0,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: Radio(
                        value: 1,
                        groupValue: groupValue,
                        onChanged: (T) {
                          setState(() {
                            groupValue = T;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Bluetooth Printer",
                        style: TextStyle(
                            letterSpacing: 2.0,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: Radio(
                        value: 2,
                        groupValue: groupValue,
                        onChanged: (T) {
                          setState(() {
                            groupValue = T;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Visibility(
              visible: !ToggleSBVnumber,
              child: Container(
                decoration: BoxDecoration(
                  color: kbuttonColor,
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF3383CD),
                      kbuttonColor,
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    'CHECK OUT',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0,
                        letterSpacing: 5),
                  ),
                  onPressed: () {
                    validate();
                    if (validated) checkout();
                    setState(() {
                      if (isprint && validated) {
                        if (groupValue == 2) {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => BluetoothPrintCheckOut(),
                            ),
                          );
                        } else if (groupValue == 1) {
                          BluetoothPrintCheckOutState object =
                              BluetoothPrintCheckOutState();
                          object.wifiPrintCheckout();
                        }
                      } else if (!isprint && validated) {
                        startTimer();
                      }
                      _rfidNumber = "Scan RFID Card";
                      CoutMethods.readOnly = false;
                      checkoutClear();
                    });
                  },
                ),
              ),
            ),
            Visibility(
              visible: ToggleSBVnumber,
              child: FlatButton(
                onPressed: () {
                  validate();
                  toggleVNButton();
                  getTicketNumberFromVehicleNumber(CoutMethods.vehicleNumber);
                  CoutMethods.fetchClear();
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: kbuttonColor,
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF3383CD),
                        kbuttonColor,
                      ],
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 75),
                  child: Text(
                    'FETCH TICKET NUMBER',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15.0,
                        letterSpacing: 0),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !ToggleSBVnumber,
              child: FlatButton(
                padding: EdgeInsets.only(
                    left: 60.0, right: 60.0, top: 15.0, bottom: 15.0),
                onPressed: () async {
                  codeScanner = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true, ScanMode.BARCODE); //BarcodeScanner.scan();
                  print(codeScanner);
                  setState(() {
                    qrCodeResult = codeScanner;
                    getTicketNumberFromScanner(qrCodeResult);
                  });
                },
                child: Text(
                  "OPEN SCANNER",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.5), width: 3.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            Visibility(
              visible: !isprint && !ToggleSBVnumber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text("Ticket Number")),
                        DataColumn(label: Text("Vehicle Number")),
                        DataColumn(label: Text("Cost")),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(tabTNo)),
                          DataCell(Text(tabVno)),
                          DataCell(Text(tabCost)),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  isprintToggled() {
    setState(() {
      isprint = !isprint;
    });
  }

  // ignore: missing_return
  Future<String> readNFC() {
    Stream<NDEFMessage> stream = NFC.readNDEF();
    stream.listen((NDEFMessage message) {
//      print(message.data.toUpperCase());
      return message.data;
    });
  }

  validate() {
    if (_formKey.currentState.validate()) {
      validated = true;
      return;
    } else {
      _formKey.currentState.save();
    }
  }

  toggleVNButton() {
    setState(() {
      ToggleSBVnumber = !ToggleSBVnumber;
    });
  }

  Future<void> getTicketNumberFromScanner(String codeResult) async {
    Map data = {
      'transaction_id': codeResult,
    };
    var response =
        await http.post('http://$url/NEW/getTicketNumberTid.php', body: data);
    try {
      if (response.statusCode == 200) {
        var ticketNumberJason = json.decode(response.body);
        for (var tnumber in ticketNumberJason) {
          TicketNumberObject = TicketInit.fromJson(tnumber);
        }
        setState(() {
          // ignore: unrelated_type_equality_checks
          if (TicketNumberObject.ticketNumber == false) {
          } else
            CoutMethods.setTicketNumber(TicketNumberObject.ticketNumber);
          Dupnumber = TicketNumberObject.ticketNumber;
        });
      }
    } catch (Exception) {
      showError("No such vehicle found!");
      checkoutClear();
    }
  }

  Future<void> getTicketNumberFromAlternateId(String alterNumber) async {
    Map data = {
      'alternate_id': alterNumber,
    };
    var response =
        await http.post('http://$url/NEW/getTicketNumberAid.php', body: data);
    try {
      if (response.statusCode == 200) {
        var ticketNumberJason = json.decode(response.body);
        for (var tnumber in ticketNumberJason) {
          TicketNumberObject = TicketInit.fromJson(tnumber);
        }
        setState(() {
          if (TicketNumberObject.ticketNumber == "false") {
          } else
            CoutMethods.setTicketNumber(TicketNumberObject.ticketNumber);
        });
      }
    } catch (Exception) {
      showError("Please enter a valid number");
    }
  }

  Future<void> getTicketNumberFromVehicleNumber(String vehicleNumber) async {
    Map data = {
      'vehicle_number': vehicleNumber,
    };
    var response = await http
        .post('http://$url/NEW/getTicketNumberVehilceNumber.php', body: data);
    try {
      if (response.statusCode == 200) {
        var ticketNumberJason = json.decode(response.body);
        setState(() {
          if (ticketNumberJason == "F") {
            showError("No such vehicle checked in.");
          } else {
            for (var tnumber in ticketNumberJason) {
              TicketNumberObject = TicketInit.fromJson(tnumber);
            }
            CoutMethods.setTicketNumber(TicketNumberObject.ticketNumber);
          }
        });
      }
    } catch (Exception) {
      showError("Error! Please RETRY");
    }
  }

  Future<void> checkout() async {
    Map data = {
      "ticket_number": CoutMethods.ticketNumber,
      "user_name": nameDisp,
    };
    var response = await http.post('http://$url/NEW/update.php', body: data);
    try {
      if (response.statusCode == 200) {
        showError("Checked out/Already checked out");
      }
    } catch (Exception) {
      showError("Error while checking out. RETRY");
    }
  }

  void showError(String msg) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("STATUS"),
              content: Text(msg),
              actions: [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  checkoutClear() {
    validated = false;
    CoutMethods.clear();
  }

  void startTimer() {
    Timer(Duration(seconds: 1), () {
      fetchTableItems();
    });
  }

  Future<void> fetchTableItems() async {
    Map data = {
      "ticket_number": CoutMethods.ticketNumber,
    };
    var response =
        await http.post('http://$url/NEW/tabDetails.php', body: data);
    try {
      if (response.statusCode == 200) {
        var fetch = json.decode(response.body);
        setState(() {
          tabTNo = fetch[0]['ticket_number'];
          tabVno = fetch[0]['vehicle_number'];
          tabCost = fetch[0]['grand_total'];
        });
      }
    } catch (Exception) {
      showError("Error while fetching details. RETRY");
    }
  }
}
