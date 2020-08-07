import 'package:flutter/material.dart';
import 'package:tournament_app/Services/network.dart';
import 'package:tournament_app/Services/storage.dart';
import 'package:tournament_app/Ui/username_screen.dart';
import 'package:tournament_app/const.dart';
import 'package:tournament_app/Models/tournament_model.dart';
import 'Widgets/Card.dart';
import 'details_Screen.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username;
  String id;
  bool internet;
  bool isTap = true;

  @override
  void initState() {
    super.initState();
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

  Future<String> deleteAccount(String iD) async {
    final String url = '$baseUrl/user/delete/$iD';
    http.Response res = await http.delete(url);
    if (res.statusCode == 201) {
      return 'Success';
    } else
      return 'Error';
  }

  void action(String choice) async {
    if (choice == 'Delete Account') {
      String result = await deleteAccount(id);
      if (result == 'Success') {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          remove('user');
          return UsernameScreen();
        }));
      }
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        remove('user');
        return UsernameScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Touranament'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: action,
              itemBuilder: (context) {
                return DotMenu.choices.map((String c) {
                  return PopupMenuItem<String>(value: c, child: Text(c));
                }).toList();
              }),
        ],
      ),
      body: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            username == null ? '' : username,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder<List<Tournament>>(
          future: getTournament(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Text('No Tournaments are Available'),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error),
                );
              } else if (snapshot.hasData) {
                var data = snapshot.data;
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return CardDesign(
                            infolist: data,
                            index: i,
                            color: data[i].joinedUsers.contains(id)
                                ? Colors.grey
                                : buttonColor,
                            buttonOnTap: !data[i].joinedUsers.contains(id) &&
                                        data[i].joined < 100 &&
                                    isTap
                                ? () async {
                                    setState(() {
                                      isTap = false;
                                    });
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
                  ),
                );
              }
            }
            return CircularProgressIndicator();
          },
        ),
      ]),
    );
  }
}

class DotMenu {
  static const String delete = 'Delete Account';
  static const String signOut = 'Sign Out';

  static const List<String> choices = [delete, signOut];
}
