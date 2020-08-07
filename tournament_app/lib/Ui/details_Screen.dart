import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:tournament_app/Models/tournament_model.dart';
import 'package:tournament_app/const.dart';
import 'Widgets/label_text.dart';
import 'Widgets/tile.dart';
import 'package:tournament_app/Services/network.dart';

class DetailsScreen extends StatelessWidget {
  final Tournament tournamentinfo;

  DetailsScreen({this.tournamentinfo});

  int time() {
    String date = tournamentinfo.date;
    String time = tournamentinfo.time;
    String cutTime = time.substring(0, time.length - 2);
    var format = cutTime + ':00';
    var finalFormat = format.replaceAll(new RegExp(r"\s+"), "");
    var parsedDate = DateTime.parse(date);
    var parsedTime = TimeOfDay(
        hour: int.parse(finalFormat.split(":")[0]),
        minute: int.parse(finalFormat.split(":")[1]));
    var finalDateTime = DateTime(parsedDate.year, parsedDate.month,
        parsedDate.day, parsedTime.hour, parsedTime.minute);

    var remainTime =
        DateTime.parse(finalDateTime.toString()).millisecondsSinceEpoch;
    return remainTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Text(
                'Time Left',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 75),
              child: countDownTimer(time()),
            ),
            lableText(
              'Room ID',
              EdgeInsets.only(top: 30, right: 290),
            ),
            tile(
                tournamentinfo.roomID, EdgeInsets.only(right: 230, top: 4), 25),
            lableText(
              'Room Pass',
              EdgeInsets.only(top: 10, left: 290),
            ),
            tile(tournamentinfo.roomPass, EdgeInsets.only(left: 250, top: 4),
                25),
            lableText(
              'MAP',
              EdgeInsets.only(top: 4, right: 315),
            ),
            tile(tournamentinfo.map, EdgeInsets.only(right: 230, top: 4), 25),
            lableText(
              'TYPE',
              EdgeInsets.only(top: 4, left: 320),
            ),
            tile(tournamentinfo.type, EdgeInsets.only(left: 250, top: 4), 25),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                'Joined People',
                style: TextStyle(fontSize: 25),
              ),
            ),
            FutureBuilder<List<UserIds>>(
              future: getJoinedUsers(tournamentinfo.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return Center(child: Text(snapshot.data[i].username));
                        }),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
