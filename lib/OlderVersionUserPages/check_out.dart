//import 'package:animated_text_kit/animated_text_kit.dart';
//import 'package:barcode_scan/barcode_scan.dart';
//import 'package:flutter/material.dart';
////import 'package:pms/Printer/printerConfiguration.dart';
//import 'package:printing/printing.dart';
//import 'package:pdf/widgets.dart' as pw;
//import '../ComponentsAndConstants/clipper.dart';
//import '../ComponentsAndConstants/constants.dart';
//import '../ComponentsAndConstants/textfield.dart';
//
//class Checkout extends StatefulWidget {
//  @override
//  _CheckoutState createState() => _CheckoutState();
//}
//
//class _CheckoutState extends State<Checkout> {
//  TextEditingController cRfid = TextEditingController();
//  TextEditingController cTnumber = TextEditingController();
//  TextEditingController cAnumber = TextEditingController();
//  TextEditingController cVnumber = TextEditingController();
//  // ignore: non_constant_identifier_names
//  bool Toggleprinter = true, ToggleSBVnumber = false;
//  var rfid, ticketnumber, alternativenumber, vehiclenumber;
//  String qrCodeResult = "SCAN TO KNOW THE QR RESULTS";
//  ScanResult codeScanner;
//  void clear() {
//    setState(() {
//      cRfid.clear();
//      cTnumber.clear();
//      cAnumber.clear();
//      cVnumber.clear();
//      qrCodeResult = "SCAN TO KNOW THE QR RESULTS";
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    cRfid.addListener(() {
//      rfid = cRfid.text;
//    });
//    cTnumber.addListener(() {
//      ticketnumber = cTnumber.text;
//    });
//    cAnumber.addListener(() {
//      alternativenumber = cAnumber.text;
//    });
//    cVnumber.addListener(() {
//      vehiclenumber = cVnumber.text;
//    });
//
//    return Scaffold(
//      resizeToAvoidBottomInset: false,
//      backgroundColor: Colors.white,
//      body: SafeArea(
//        child: Column(
//          children: <Widget>[
//            ClipPath(
//              clipper: MyCheckinClipper(),
//              child: Container(
//                child: Container(
//                  alignment: AlignmentDirectional.center,
//                  child: TyperAnimatedTextKit(
//                    onTap: () {
//                      setState(() {});
//                    },
//                    text: ["You can check out here."],
//                    textStyle: TextStyle(
//                        fontSize: 30.0,
//                        fontWeight: FontWeight.bold,
//                        color: ktextColor),
//                  ),
//                ),
//                padding: EdgeInsets.only(left: 40, right: 40, bottom: 40),
//                height: 175,
//                width: double.infinity,
//                decoration: BoxDecoration(
//                  gradient: LinearGradient(
//                    begin: Alignment.topRight,
//                    end: Alignment.bottomLeft,
//                    colors: [
//                      Color(0xFF3383CD),
//                      kbuttonColor,
//                    ],
//                  ),
//                ),
//              ),
//            ),
//            SizedBox(
//              height: 30,
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Icon(Icons.search, color: Colors.black, size: 30),
//                Text(
//                  "VEHICLE NUMBER",
//                  style: TextStyle(
//                      fontWeight: FontWeight.bold,
//                      color: Colors.black,
//                      fontSize: 20.0,
//                      letterSpacing: 2),
//                ),
//                AnimatedContainer(
//                  duration: Duration(milliseconds: 100),
//                  height: 40.0,
//                  width: 100,
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(50),
//                    color: ToggleSBVnumber
//                        ? Colors.greenAccent[100]
//                        : Colors.redAccent[100].withOpacity(0.5),
//                  ),
//                  child: Stack(
//                    children: <Widget>[
//                      AnimatedPositioned(
//                        duration: Duration(milliseconds: 100),
//                        curve: Curves.easeIn,
//                        top: 3.0,
//                        left: ToggleSBVnumber ? 60.0 : 0.0,
//                        right: ToggleSBVnumber ? 0.0 : 60.0,
//                        child: InkWell(
//                          onTap: toggleVNButton,
//                          child: AnimatedSwitcher(
//                              duration: Duration(milliseconds: 100),
//                              // ignore: missing_return
//                              transitionBuilder:
//                                  (Widget child, Animation<double> animation) {
//                                return RotationTransition(
//                                  child: child,
//                                  turns: animation,
//                                );
//                              },
//                              child: ToggleSBVnumber
//                                  ? Icon(
//                                      Icons.check_circle_outline,
//                                      color: Colors.green,
//                                      size: 35.0,
//                                    )
//                                  : Icon(
//                                      Icons.remove_circle_outline,
//                                      color: Colors.red,
//                                      size: 35.0,
//                                    )),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ],
//            ),
//            SizedBox(
//              height: 10,
//            ),
//            Visibility(
//              visible: !ToggleSBVnumber,
//              child: Center(
//                child: BeautyTextfield(
//                  cornerRadius: BorderRadius.circular(50),
//                  width: 400,
//                  height: 75,
//                  inputType: TextInputType.text,
//                  controller: cRfid,
//                  placeholder: "RFID number",
//                  prefixIcon: Icon(Icons.rss_feed),
//                  onSubmitted: (text) {
//                    rfid = text;
//                  },
//                  onTap: () {},
//                ),
//              ),
//            ),
//            Visibility(
//              visible: !ToggleSBVnumber,
//              child: Center(
//                child: BeautyTextfield(
//                  cornerRadius: BorderRadius.circular(50),
//                  width: 400,
//                  height: 75,
//                  inputType: TextInputType.text,
//                  controller: cAnumber,
//                  placeholder: "Alternative number",
//                  prefixIcon: Icon(Icons.autorenew),
//                  onSubmitted: (text) {
//                    alternativenumber = text;
//                  },
//                  onTap: () {},
//                ),
//              ),
//            ),
//            Visibility(
//              visible: !ToggleSBVnumber,
//              child: Center(
//                child: BeautyTextfield(
//                  cornerRadius: BorderRadius.circular(50),
//                  width: 400,
//                  height: 75,
//                  inputType: TextInputType.text,
//                  controller: cTnumber,
//                  placeholder: "Ticket number",
//                  prefixIcon: Icon(Icons.add),
//                  onSubmitted: (text) {
//                    ticketnumber = text;
//                  },
//                  onTap: () {},
//                ),
//              ),
//            ),
//            SizedBox(
//              height: 20,
//            ),
//            Visibility(
//              visible: !ToggleSBVnumber,
//              child: Text(
//                qrCodeResult,
//                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//              ),
//            ),
//            Visibility(
//              visible: ToggleSBVnumber,
//              child: Center(
//                child: BeautyTextfield(
//                  cornerRadius: BorderRadius.circular(50),
//                  width: 400,
//                  height: 75,
//                  inputType: TextInputType.text,
//                  controller: cVnumber,
//                  placeholder: "Vehicle number",
//                  prefixIcon: Icon(Icons.input),
//                  onSubmitted: (text) {
//                    vehiclenumber = text;
//                  },
//                  onTap: () {},
//                ),
//              ),
//            ),
//            SizedBox(
//              height: 20,
//            ),
//            Visibility(
//              visible: !ToggleSBVnumber,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  Icon(
//                    Icons.print,
//                    color: Colors.black,
//                    size: 30,
//                  ),
//                  Text(
//                    "TAKE PRINT",
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        color: Colors.black,
//                        fontSize: 20.0,
//                        letterSpacing: 2),
//                  ),
//                  AnimatedContainer(
//                    duration: Duration(milliseconds: 100),
//                    height: 40.0,
//                    width: 100,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(50),
//                      color: Toggleprinter
//                          ? Colors.greenAccent[100]
//                          : Colors.redAccent[100].withOpacity(0.5),
//                    ),
//                    child: Stack(
//                      children: <Widget>[
//                        AnimatedPositioned(
//                          duration: Duration(milliseconds: 100),
//                          curve: Curves.easeIn,
//                          top: 3.0,
//                          left: Toggleprinter ? 60.0 : 0.0,
//                          right: Toggleprinter ? 0.0 : 60.0,
//                          child: InkWell(
//                            onTap: togglePrinterButton,
//                            child: AnimatedSwitcher(
//                                duration: Duration(milliseconds: 100),
//                                // ignore: missing_return
//                                transitionBuilder: (Widget child,
//                                    Animation<double> animation) {
//                                  return RotationTransition(
//                                    child: child,
//                                    turns: animation,
//                                  );
//                                },
//                                child: Toggleprinter
//                                    ? Icon(
//                                        Icons.check_circle_outline,
//                                        color: Colors.green,
//                                        size: 35.0,
//                                      )
//                                    : Icon(
//                                        Icons.remove_circle_outline,
//                                        color: Colors.red,
//                                        size: 35.0,
//                                      )),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            SizedBox(
//              height: 20,
//            ),
//            Visibility(
//              visible: !ToggleSBVnumber,
//              child: FlatButton(
//                //TODO: DATABASE CONNECTION VARIABLE
//                onPressed: () {
//                  setState(() async {
//                    //TODO: Validate with the DB and push a alert message
//                    if (Toggleprinter)
////                       await Navigator.push(
////                        context,
////                        new MaterialPageRoute(
////                          builder: (context) => Print(),
////                        ),
////                      );
//                      print(codeScanner);
//                    clear();
//                  });
//                },
//                child: Container(
//                  decoration: BoxDecoration(
//                    color: kbuttonColor,
//                    borderRadius: BorderRadius.circular(50),
//                    gradient: LinearGradient(
//                      begin: Alignment.topRight,
//                      end: Alignment.bottomLeft,
//                      colors: [
//                        Color(0xFF3383CD),
//                        kbuttonColor,
//                      ],
//                    ),
//                  ),
//                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 75),
//                  child: Text(
//                    'CHECK OUT',
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        color: Colors.white,
//                        fontSize: 20.0,
//                        letterSpacing: 5),
//                  ),
//                ),
//              ),
//            ),
//            Visibility(
//              visible: ToggleSBVnumber,
//              child: FlatButton(
//                //TODO: DATABASE CONNECTION VARIABLE
//                onPressed: () {
//                  setState(() async {});
//                },
//                child: Container(
//                  decoration: BoxDecoration(
//                    color: kbuttonColor,
//                    borderRadius: BorderRadius.circular(50),
//                    gradient: LinearGradient(
//                      begin: Alignment.topRight,
//                      end: Alignment.bottomLeft,
//                      colors: [
//                        Color(0xFF3383CD),
//                        kbuttonColor,
//                      ],
//                    ),
//                  ),
//                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 75),
//                  child: Text(
//                    'SHOW DATA',
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        color: Colors.white,
//                        fontSize: 20.0,
//                        letterSpacing: 5),
//                  ),
//                ),
//              ),
//            ),
//            SizedBox(
//              height: 10.0,
//            ),
//            Visibility(
//              visible: !ToggleSBVnumber,
//              child: FlatButton(
//                padding: EdgeInsets.all(15.0),
//                onPressed: () async {
//                  codeScanner = await BarcodeScanner.scan();
//                  setState(() {
//                    qrCodeResult = codeScanner.rawContent;
//                  });
//                },
//                child: Text(
//                  "Open Scanner",
//                  style: TextStyle(
//                      color: Colors.blue, fontWeight: FontWeight.bold),
//                ),
//                shape: RoundedRectangleBorder(
//                    side: BorderSide(color: Colors.blue, width: 3.0),
//                    borderRadius: BorderRadius.circular(20.0)),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//
//  toggleVNButton() {
//    setState(() {
//      ToggleSBVnumber = !ToggleSBVnumber;
//    });
//  }
//
//  Future<void> printDocument() async {
//    return Printing.layoutPdf(
//      onLayout: (pageFormat) {
//        final doc = pw.Document();
//        doc.addPage(
//          pw.Page(
//            build: (pw.Context context) => pw.Center(
//              child: pw.Text("RETURN : $ticketnumber"),
//            ),
//          ),
//        );
//        return doc.save();
//      },
//    );
//  }
//
//  togglePrinterButton() {
//    setState(() {
//      //TODO : Printer API Call with Printable PDF.
//      Toggleprinter = !Toggleprinter;
//    });
//  }
//}
