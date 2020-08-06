import 'package:flutter/material.dart';
import 'package:tournament_app/Models/tournament_model.dart';
import 'package:tournament_app/const.dart';
import 'Widgets/label_text.dart';
import 'Widgets/tile.dart';
import 'package:tournament_app/Services/network.dart';

class DetailsScreen extends StatelessWidget {
  final Tournament tournamentinfo;

  DetailsScreen({this.tournamentinfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Text('Time Left', style: TextStyle(fontSize: 30),),
            ),
            Container(
              child: Text('Place Holder', style: TextStyle(fontSize: 18),),
            ),
            lableText(
              'Room ID',
              EdgeInsets.only(top: 30, right: 290),
            ),
            tile(tournamentinfo.roomID, EdgeInsets.only(right: 230, top: 4), 25),
            lableText(
              'Room Pass',
              EdgeInsets.only(top: 10, left: 290),
            ),
            tile(tournamentinfo.roomPass, EdgeInsets.only(left: 250, top: 4), 25),
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
                  } return CircularProgressIndicator();
                },
                ),
          ],
        ),
      ),
    );
  }
}
