import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  Cards({@required this.colors, this.cards, this.onPress});
  final Color colors;
  final Widget cards;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cards,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colors,
        ),
      ),
    );
  }
}
