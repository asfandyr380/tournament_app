import 'package:flutter/material.dart';

Widget lableText(String lable, EdgeInsetsGeometry margin) {
  return Container(
    margin: margin,
    child: Text(
      lable,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}