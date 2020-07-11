import 'dart:convert';
import 'package:flutter/material.dart';
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
    String url = 'http://192.168.10.3:3000/tournaments';
    var res = await http.get(url);
    var jsondata = json.decode(res.body);

    for (var data in jsondata) {
      Tournament info = Tournament(
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
            Expanded(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    return CardDesign(
                      index: i,
                      infolist: list,
                      buttonOnTap: () async {
                        await updateJoin(list[i].joined += 1, list[i].id);
                        setState(() {});
                      },
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              tournamentinfo: list[i],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ]),
    );
  }
}
