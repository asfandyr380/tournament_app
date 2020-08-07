import 'package:flutter/material.dart';
import 'package:tournament_app/const.dart';

Widget tile(String value, EdgeInsetsGeometry margin, double textSize) {
  return Container(
    width: 140,
    height: 35,
    padding: EdgeInsets.only(left: 19, top: 4),
    margin: margin,
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(7),
      boxShadow: [
        BoxShadow(
          color: Colors.black38,
          blurRadius: 5,
        ),
      ],
    ),
    child: Text(
      value,
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: textSize),
    ),
  );
}