import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:tournament_app/Ui/Widgets/custom_Button.dart';
import 'package:tournament_app/const.dart';
import 'package:http/http.dart' as http;
import 'package:tournament_app/Models/tournament_model.dart';
import 'details_Screen.dart';

List<Tournament> list = [];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  Future<List<Tournament>> getTournament() async {
    var res = await http.get('http://192.168.10.8:3000/tournaments');
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
                    return getTournamentDetails(
                      list[i].title,
                      list[i].time,
                      list[i].joined,
                      list[i].date,
                      list[i].map,
                      list[i].type,
                      context,
                      () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailsScreen(
                            tournamentinfo: list[i],
                          );
                        }));
                      },
                    );
                  }),
            ),
          ]),
    );
  }
}

Widget getTournamentDetails(String title, String time, int joined, String date,
    String map, String type, BuildContext ctx, onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 346,
      height: 274,
      margin: EdgeInsets.only(left: 10, right: 10, top: 40),
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
          Row(
            children: <Widget>[
              Container(
                width: 250,
                margin: EdgeInsets.only(top: 30, left: 10),
                child: Expanded(
                  child: FAProgressBar(
                    displayText: ' Joined',
                    size: 20,
                    progressColor: buttonColor,
                    maxValue: 100,
                    currentValue: joined,
                  ),
                ),
              ),
              CustomButton(
                width: 100,
                lable: 'Join',
                margin: EdgeInsets.only(left: 20, top: 25),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
