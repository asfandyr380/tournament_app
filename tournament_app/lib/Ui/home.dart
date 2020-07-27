import 'package:flutter/material.dart';
import 'package:tournament_app/Services/network.dart';
import 'package:tournament_app/Services/storage.dart';
import 'package:tournament_app/Ui/username_screen.dart';
import 'package:tournament_app/const.dart';
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
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40),
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 50,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          remove('user');
                      return UsernameScreen();
                    }));
                  }),
            ),
            Container(
              margin: EdgeInsets.only(top: 50, left: 80),
              child: Text(
                username,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        FutureBuilder<List<Tournament>>(
          future: getTournament(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return CardDesign(
                        isAdmin: false,
                        infolist: data,
                        index: i,
                        color: data[i].joinedUsers.contains(id) ? Colors.grey: buttonColor,
                        buttonOnTap: !data[i].joinedUsers.contains(id) && data[i].joined < 100
                            ? () async {
                                await updateJoin(data, i, id);
                                await saveCurrentUserid(id, data, i);
                                setState(() {});
                                print(data[i].joinedUsers);
                                print(id);
                              }
                            : null,
                        onPressed: data[i].joinedUsers.contains(id)
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      tournamentinfo: data[i],
                                    ),
                                  ),
                                );
                              }
                            : null,
                      );
                    }),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ]),
    );
  }
}
