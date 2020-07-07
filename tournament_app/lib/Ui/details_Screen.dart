import 'package:flutter/material.dart';
import 'package:tournament_app/Models/tournament_model.dart';
import 'package:tournament_app/const.dart';
import 'Widgets/label_text.dart';
import 'Widgets/tile.dart';

class DetailsScreen extends StatelessWidget {

  final Tournament tournamentinfo;

  DetailsScreen({this.tournamentinfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          lableText(
            'Room ID',
            EdgeInsets.only(top: 50, right: 270),
          ),
          tile(tournamentinfo.roomID, EdgeInsets.only(right: 230, top: 4), 25),
          lableText(
            'Room Pass',
            EdgeInsets.only(top: 10, left: 290),
          ),
          tile(tournamentinfo.roomPass, EdgeInsets.only(left: 250, top: 4), 25),
          lableText(
            'MAP',
            EdgeInsets.only(top: 4, right: 290),
          ),
          tile(tournamentinfo.map, EdgeInsets.only(right: 230, top: 4), 25),
          lableText(
            'TYPE',
            EdgeInsets.only(top: 4, left: 320),
          ),
          tile(tournamentinfo.type, EdgeInsets.only(left: 250, top: 4), 25),
          lableText(
            'Date/Time',
            EdgeInsets.only(top: 4, right: 250),
          ),
          tile(tournamentinfo.time, EdgeInsets.only(right: 230, top: 4), 15),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Joined People',
              style: TextStyle(fontSize: 25),
            ),
          ),
          Expanded(child: ListView.builder(itemBuilder: (context, i) {
            // TODO: Show name of the Joined Users Here
          })),
        ],
      ),
    );
  }
}

