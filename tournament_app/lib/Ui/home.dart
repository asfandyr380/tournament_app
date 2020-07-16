import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tournament_app/Models/enroll.dart';
import 'package:tournament_app/Services/network.dart';
import 'package:tournament_app/const.dart';
import 'package:http/http.dart' as http;
import 'package:tournament_app/Models/tournament_model.dart';
import 'Widgets/Card.dart';
import 'details_Screen.dart';

List<Tournament> list = [];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Tournament>> getTournament() async {
    String url = 'http://192.168.10.4:3000/tournaments';
    var res = await http.get(url);
    var jsondata = json.decode(res.body);
    Enrolled enroll = Enrolled(userJoined: "");
    for (var data in jsondata) {
      Tournament info = Tournament(
          enroll: enroll,
          id: data['_id'],
          date: data['date'],
          time: data['time'],
          roomID: data['roomId'],
          roomPass: data['roomPass'],
          joined: data['joined'],
          map: data['mapType'],
          title: data['title'],
          type: data['type']);
      setState(() {
        list.add(info);
      });
    }
    print(list.length);
    return list;
  }

  @override
  void initState() {
    super.initState();
    getTournament();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50, right: 200),
              child: Text(newUser.username,
                style: TextStyle(fontSize: 30),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    return CardDesign(
                      isAdmin: false,
                      index: i,
                      infolist: list,
                      buttonOnTap: list[i].enroll.userJoined != newUser.username 
                          ? () async {
                              await updateJoin(list, i);
                              setState(() {
                                list[i].enroll.userJoined = newUser.username;
                              });
                              print(i);
                            }
                          : null,
                      onPressed: list[i].enroll.userJoined == newUser.username
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    tournamentinfo: list[i],
                                  ),
                                ),
                              );
                            }
                          : null,
                    );
                  }),
            ),
          ]),
    );
  }
}
