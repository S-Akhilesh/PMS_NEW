import 'package:flutter/material.dart';
import 'constants.dart';

class GenderIcon extends StatelessWidget {
  final String gender;
  final Icon icon;

  GenderIcon({@required this.gender, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon,
        SizedBox(
          height: 15,
        ),
        Text(
          gender,
          style: kLableTextStyle,
        )
      ],
    );
  }
}
