import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tournament_app/Services/network.dart';
import 'package:tournament_app/Services/storage.dart';
import 'package:tournament_app/const.dart';
import 'package:http/http.dart' as http;
import 'package:tournament_app/Models/tournament_model.dart';
import 'Widgets/Card.dart';
import 'details_Screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String username;
  String id;

  Future<List<Tournament>> getTournament() async {
    String url = '$baseUrl/tournaments';
    var res = await http.get(url);
    final decodedBody = json.decode(res.body).cast<Map<String, dynamic>>();
    if (res.statusCode == 200 && decodedBody != null) {
      return decodedBody.map<Tournament>((item) => Tournament.fromJson(item)).toList();
    } else {
      return throw Exception('error');
    }
  }

  @override
  void initState() {
    super.initState();
    getTournament(); 
    read('user').then((value) {
      setState(() {
        username = value;
      });
      read('id').then((value) {
        setState(() {
          id = value;
        });
      });
    });
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
              child: Text(username,
                style: TextStyle(fontSize: 30),
              ),
            ),
            FutureBuilder<List<Tournament>>(
              future: getTournament(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return CardDesign(
                            isAdmin: false,
                            infolist: snapshot.data,
                            index: i,
                            buttonOnTap: () async {
                              await updateJoin(snapshot.data, i, id);
                              print(snapshot.data[i].joinedUsers);
                            },
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    tournamentinfo: snapshot.data[i],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  );
                }
                return Container();
              },
            ),
          ]),
    );
  }
}