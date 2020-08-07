import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';

Widget countDownTimer(int time) {
  return CountdownTimer(
      endTime: time,
      defaultDays: "==",
      defaultHours: "--",
      defaultMin: "**",
      defaultSec: "++",
      daysSymbol: "days",
      hoursSymbol: "hrs ",
      minSymbol: "min ",
      secSymbol: "sec",
      daysTextStyle: TextStyle(
        fontSize: 30,
      ),
      hoursTextStyle: TextStyle(
        fontSize: 30,
      ),
      minTextStyle: TextStyle(
        fontSize: 30,
      ),
      secTextStyle: TextStyle(
        fontSize: 30,
      ),
      daysSymbolTextStyle: TextStyle(
        fontSize: 20,
      ),
      hoursSymbolTextStyle: TextStyle(
        fontSize: 20,
      ),
      minSymbolTextStyle: TextStyle(
        fontSize: 20,
      ),
      secSymbolTextStyle: TextStyle(
        fontSize: 20,
      ));
}