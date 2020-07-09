import 'package:flutter/material.dart';

class CoutWidgets {
  TextEditingController _cAlternateNumber = TextEditingController();
  TextEditingController _cVehicleNumber = TextEditingController();
  TextEditingController _cTicketNumber = TextEditingController();
  FocusNode _fAlternate = FocusNode();
  FocusNode _fVehicle = FocusNode();
  bool readOnly = false;
  FocusNode _fTicketNumber = FocusNode();
  String alternateNumber = null, vehicleNumber, ticketNumber;

  void clear() {
    _cTicketNumber.clear();
    _cVehicleNumber.clear();
    _cAlternateNumber.clear();
  }

  // ignore: missing_return
  String setTicketNumber(String ticketnumber) {
    //TODO: FETCH TICKET ID USING QRCODE AND INITIALISE TO ticketnumber
    _cTicketNumber = TextEditingController(text: ticketnumber);
    ticketNumber = ticketnumber;
    readOnly = true;
  }

  Widget buildANumber(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            focusNode: _fAlternate,
            onFieldSubmitted: (term) {
              _fieldFocusChange(context, _fAlternate, _fVehicle);
            },
            textInputAction: TextInputAction.next,
            onChanged: (input) {
              alternateNumber = input;
            },
            style: TextStyle(fontSize: 25.0),
            controller: _cAlternateNumber,
            decoration: InputDecoration(
              helperText: "ENTER ALTERNATE NUMBER",
              helperStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
              icon: Icon(
                Icons.find_replace,
                size: 30,
              ),
            ),
            cursorColor: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildVNumber(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            focusNode: _fVehicle,
            onFieldSubmitted: (term) {
              _fieldFocusChange(context, _fVehicle, _fTicketNumber);
            },
            textInputAction: TextInputAction.next,
            style: TextStyle(fontSize: 25.0),
            validator: (input) {
              if (input.isEmpty)
                return "This field is requried";
              else
                return null;
            },
            controller: _cVehicleNumber,
            decoration: InputDecoration(
              helperText: "ENTER VEHICLE NUMBER",
              helperStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black),
              icon: Icon(
                Icons.input,
                size: 30,
              ),
            ),
            cursorColor: Colors.black,
            onChanged: (String text) {
              vehicleNumber = text;
            },
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }

  Widget buildticketNumber(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            readOnly: readOnly,
            focusNode: _fTicketNumber,
            style: TextStyle(fontSize: 25.0),
            validator: (input) {
              if (input.isEmpty)
                return "This field is requried";
              else
                return null;
            },
            textInputAction: TextInputAction.done,
            controller: _cTicketNumber,
            decoration: InputDecoration(
              helperText: "ENTER TICKET NUMBER",
              helperStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
              icon: Icon(
                Icons.add,
                size: 30,
              ),
            ),
            cursorColor: Colors.black,
            onChanged: (String text) {
              ticketNumber = text;
            },
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
