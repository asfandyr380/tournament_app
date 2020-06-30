import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tournament_app/const.dart';
import 'package:http/http.dart' as http;
import 'package:tournament_app/Models/tournament_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Tournament> list = [];

  Future<List<Tournament>> getTournament() async {
    var res = await http.get('http://192.168.10.2:3000/tournaments');
    var jsondata = json.decode(res.body);

    for (var data in jsondata) {
      Tournament info = Tournament(
          date: data['date'],
          time: data['time'],
          roomID: data['roomId'],
          roomPass: data['roomPass'],
          joined: data['joined'],
          map: data['mapType'],
          title: data['title'],
          type: data['type']);
      list.add(info);
    }
    print(list.length);
    return list;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
                future: getTournament(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return getTournamentDetails(
                                snapshot.data[index].title,
                                snapshot.data[index].time,
                                snapshot.data[index].roomID,
                                snapshot.data[index].roomPass,
                                snapshot.data[index].joined,
                                snapshot.data[index].date,
                                snapshot.data[index].map,
                                snapshot.data[index].type);
                          }),
                    );
                  } else {
                    return Text('NO Tournaments Available');
                  }
                }),
          ]),
    );
  }
}

Widget getTournamentDetails(String title, String time, String roomId,
    String roomPass, int joined, String date, String map, String type) {
  return Container(
    width: 346,
    height: 274,
    margin: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
    decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 10)],
        borderRadius: BorderRadius.circular(10),
        color: cardColor),
    child: Column(
      children: <Widget>[
        Text(
          title,
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
              date,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
             SizedBox(
              width: 30,
            ),
            Text(
              time,
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
              map,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
             SizedBox(
              width: 30,
            ),
            Text(
              type,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
