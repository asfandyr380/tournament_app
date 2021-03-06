import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:tournament_app/const.dart';
import 'custom_Button.dart';

class CardDesign extends StatelessWidget {
  final int index;
  final List infolist;
  final Function onPressed;
  final Function buttonOnTap;
  final Color color;

  CardDesign(
      {this.infolist,
      this.index,
      this.onPressed,
      this.buttonOnTap,
      this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 346,
        height: 285,
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 10)],
            borderRadius: BorderRadius.circular(10),
            color: cardColor),
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
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              margin: EdgeInsets.only(
                top: 30,
              ),
              child: RoundedProgressBar(
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
            Container(
              margin: EdgeInsets.only(top: 10),
              child: CustomButton(
                color: color,
                onPressed: buttonOnTap,
                lable: 'Join',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
