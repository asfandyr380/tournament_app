import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:tournament_app/const.dart';

Widget card02(
    {List infolist,
    int index,
    Function onPressed,
    var width,
    var height,
    Function onButtonPress}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: height * 0.18,
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black54, blurRadius: 5),
        ],
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  infolist[index].title,
                  style: TextStyle(fontSize: 40),
                ),
                Container(
                  child: deleteButton(onPressed: onButtonPress),
                ),
              ],
            ),
            Container(
              width: width * 0.85,
              child: RoundedProgressBar(
                margin: EdgeInsets.only(top: 20),
                childCenter: Text(
                  '${infolist[index].joined}',
                  style: TextStyle(color: Colors.black),
                ),
                style: RoundedProgressBarStyle(
                  colorProgress: progressBarColor,
                  borderWidth: 0,
                  widthShadow: 0,
                ),
                height: 20,
                percent: infolist[index].joined.toDouble(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget deleteButton({Function onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 30,
      width: 70,
      decoration: BoxDecoration(
        color: dateTimePickerColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(child: Text('Remove')),
    ),
  );
}
