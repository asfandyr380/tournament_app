import 'package:flutter/material.dart';

const baseUrl = 'http://192.168.10.3:3000';

// all The Colors Used In The Entire App
const Color backgorundColor = Color(0xff474747);
const Color buttonColor = Color(0xff56C6DE);
const Color cardColor = Color(0xff55554E);
const Color adminContainerColor = Color(0xff6C9092);
const Color dateTimePickerColor = Color(0xff7A4C5C);
const Color adminPanalTextColor = Color(0xffD2F5F4);
const Color adminHomeContainerColor = Color(0xff6C9092);

// TextField Input Decoractions
final InputDecoration inputDecoration = InputDecoration(
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(44),
    borderSide: BorderSide(color: Colors.red, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(44),
    borderSide: BorderSide(color: Colors.white, width: 2),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(44),
  ),
  hintText: 'Enter Your PUBG Username',
  labelText: 'PUBG Username',
);
