import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:pms/ModelClasses/VehicelType.dart';
import 'package:pms/Printing/bluetoothprinter.dart';
import 'package:pms/Printing/wifiprinter.dart';
import '../ComponentsAndConstants/constants.dart';
import 'Methods/CinFormFields.dart';
import '../ComponentsAndConstants/flags.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class nCheckin extends StatefulWidget {
  @override
  _nCheckinState createState() => _nCheckinState();
}

// ignore: camel_case_types
class _nCheckinState extends State<nCheckin> {
  //TODO:List for selecting the vehicle type from DB.
  var vehicleType = new List<Welcome>();
  String msg;
  bool _loading = false;
  var message;
  List<String> _vtype = new List<String>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool bikeSelectedFlag = false;
  String _rfidNumber = "Scan RFID Card", selecteditem;
  bool isprint = false, validated = false;
  int groupValue = 1;
  // ignore: non_constant_identifier_names
  CinWidgets CinMethods = CinWidgets();

  @override
  void initState() {
    _loading = true;
    getVehicleType();
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
          "You can check in here.",
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300),
        ),
      ),
      body: _loading
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(150.0),
              child: LinearProgressIndicator(),
            ))
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: Visibility(
                      visible: rfidflag,
                      child: Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.only(
                              left: 120.0,
                              right: 120.0,
                              top: 15.0,
                              bottom: 15.0),
                          onPressed: () {
                            setState(() {
                              Stream<NDEFMessage> stream = NFC.readNDEF();
                              stream.listen((NDEFMessage message) {
                                print(message.data);
                                _rfidNumber = message.data;
                              });
                            });
                          },
                          child: Expanded(
                            child: Center(
                              child: Text(
                                _rfidNumber,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black.withOpacity(0.5),
                                width: 3.0),
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
                        CinMethods.buildANumber(context),
                        CinMethods.buildVNumber(context),
                        Visibility(
                          visible: bikeSelectedFlag & helmetflag,
                          child: CinMethods.buildNoHelmet(context),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Container(
                            height: ktextfieldheight,
                            width: ktextfieldwidth,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Text(
                                      "SELECT VEHICLE TYPE",
                                      style: TextStyle(
                                          letterSpacing: 0,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                    underline: Container(),
                                    items: _vtype.map((String dropdownitem) {
                                      return DropdownMenuItem<String>(
                                        value: dropdownitem,
                                        child: Text(
                                          dropdownitem,
                                          style: TextStyle(
                                              letterSpacing: 0,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String value) {
                                      setState(() {
                                        selecteditem = value;
                                        if (defaultEnabled) {
                                          _vtype.removeRange(0, _vtype.length);
                                          _vtype.add(selecteditem);
                                        }

                                        if (selecteditem == 'bike') {
                                          bikeSelectedFlag = true;
                                        } else
                                          bikeSelectedFlag = false;
                                        //print(selecteditem.toString());
                                      });
                                    },
                                    value: selecteditem,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.print, color: Colors.black, size: 25),
                      Text(
                        "PRINT RECIEPT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
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
                  Visibility(
                    visible: isprint,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "WiFi Printer",
                              style: TextStyle(
                                  letterSpacing: 3.0,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: Radio(
                              value: 1,
                              groupValue: groupValue,
                              onChanged: (T) {
                                print(T);
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
                                print(T);
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
                  Container(
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
                      child: Text(
                        'CHECK IN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0,
                            letterSpacing: 5),
                      ),
                      onPressed: () {
                        validate();
                        setState(() {
                          if (isprint && validated) {
                            if (groupValue == 2) {
                              print("BLUETOOTH");
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => BluetoothPrint(),
                                ),
                              );
                            } else if (groupValue == 1) {
                              WifiPrinter wifiPrinter = WifiPrinter();
                              wifiPrinter.wifiPrint();
                            }
                            _rfidNumber = "Scan RFID Card";
                          }
                        });
                      },
                    ),
                  ),
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
      print(message.data.toUpperCase());
      return message.data;
    });
  }

  validate() {
    if (_formKey.currentState.validate()) {
      validated = true;
      checkinInsert();
      CinMethods.clear();
      return;
    } else {
      _formKey.currentState.save();
    }
  }

  Future<void> checkinInsert() async {
    Map data = {
      "RfidNumberT": _rfidNumber,
      "idNumber": CinMethods.alternateNumber,
      "vnumber": CinMethods.vehicleNumber,
      "vtype": selecteditem,
      "helmet_count": CinMethods.numberOfHelmet,
    };
    print(data);

    message = await http.post('http://$url/NEW/insert.php', body: data);
    try {
      if (message.statusCode == 200) {
        setState(() {
          msg = message.body;
        });
        showError(msg);
      }
    } catch (Exception) {
      print("Agalla");
    }
  }

  Future<void> getVehicleType() async {
    var response = await http.post('http://$url/NEW/getVehicleType.php');
    try {
      if (response.statusCode == 200) {
        var vehicleTypeList = json.decode(response.body);
        for (var types in vehicleTypeList) {
          vehicleType.add(Welcome.fromJson(types));
        }
        for (int i = 0; i < vehicleTypeList.length; i++) {
          _vtype.add(vehicleType[i].vehicleType);
        }
        _vtype.remove("helmet");
      }
    } catch (Exception) {
      print("Agalla");
    }
    setState(() {
      _loading = false;
    });
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
}
