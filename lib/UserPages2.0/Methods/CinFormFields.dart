import 'package:flutter/material.dart';

class CinWidgets {
  TextEditingController _cAlternateNumber = TextEditingController();
  TextEditingController _cVehicleNumber = TextEditingController();
  TextEditingController _cNumberOfHelmet = TextEditingController();
  FocusNode _fAlternate = FocusNode();
  FocusNode _fVehicle = FocusNode();
  FocusNode _fNumberHelmet = FocusNode();
  String alternateNumber = "", vehicleNumber, numberOfHelmet = "0";

  void clear() {
    _cNumberOfHelmet.clear();
    _cVehicleNumber.clear();
    _cAlternateNumber.clear();
    alternateNumber = "";
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
              _fieldFocusChange(context, _fVehicle, _fNumberHelmet);
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

  Widget buildNoHelmet(BuildContext context) {
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
            focusNode: _fNumberHelmet,
            style: TextStyle(fontSize: 25.0),
            validator: (input) {
              if (input.isEmpty)
                return "This field is requried";
              else
                return null;
            },
            textInputAction: TextInputAction.done,
            controller: _cNumberOfHelmet,
            decoration: InputDecoration(
              helperText: "NO. Of HELMET's",
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
              numberOfHelmet = text;
            },
            keyboardType: TextInputType.number,
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
