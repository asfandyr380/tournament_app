import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:tournament_app/const.dart';

Widget card02({List infolist, int index}) {
  return GestureDetector(
    child: Container(
      height: 150,
      width: 10,
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
            Text(
              infolist[index].title,
              style: TextStyle(fontSize: 57),
            ),
            Container(
              width: 350,
              child: Expanded(
                child: RoundedProgressBar(
                  margin: EdgeInsets.only(top: 20),
                  childCenter: Text(
                    '${infolist[index].joined}',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: RoundedProgressBarStyle(
                    colorProgress: buttonColor,
                    borderWidth: 0,
                    widthShadow: 0,
                  ),
                  height: 20,
                  percent: infolist[index].joined.toDouble(),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
