import 'package:flutter/material.dart';

const header = {'Content-Type': 'application/json; charset=UTF-8'};
const baseUrl = 'https://lit-sands-88957.herokuapp.com';

// all The Colors Used In The Entire App
const Color backgorundColor = Color(0xff474747);
const Color buttonColor = Color(0xff167685);
const Color progressBarColor = Color(0xff56C6DE);
const Color styleSheetColor = Color(0xff41CDD5);
const Color cardColor = Color(0xff55554E);
const Color dateTimePickerColor = Color(0xff7A4C5C);

// TextField Input Decoractions
final InputDecoration inputDecoration = InputDecoration(
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.red, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.white, width: 2),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  hintText: 'Enter Your PUBG Username',
  labelText: 'PUBG Username',
);