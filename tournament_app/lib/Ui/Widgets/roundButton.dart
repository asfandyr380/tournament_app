import 'package:flutter/material.dart';
import 'package:tournament_app/const.dart';

Widget roundButton({context, Function onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 70,
      width: 70,
      child: Icon(Icons.add, size: 35),
      margin: EdgeInsets.only(
          top: 120, left: MediaQuery.of(context).size.width * 0.4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: buttonColor,
      ),
    ),
  );
}