import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:tournament_app/const.dart';

Widget card02({List infolist, int index}) {
  return GestureDetector(
      child: Container(
      height: 250,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Date',
                  style: TextStyle(fontSize: 27),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Time',
                  style: TextStyle(fontSize: 27),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  infolist[index].date,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  infolist[index].time,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'MAP',
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'TYPE',
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  infolist[index].map,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  infolist[index].type,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 350,
                  margin: EdgeInsets.only(top: 30, left: 20),
                  child: Expanded(
                    child: RoundedProgressBar(
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
            )
          ],
        ),
      ),
    ),
  );
}