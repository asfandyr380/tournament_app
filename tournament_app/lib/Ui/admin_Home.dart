import 'package:flutter/material.dart';
import 'package:tournament_app/Models/tournament_model.dart';
import 'package:tournament_app/Services/network.dart';
import 'package:tournament_app/Services/storage.dart';
import 'package:tournament_app/Ui/Add_Screen.dart';
import 'package:tournament_app/Ui/username_screen.dart';
import 'package:tournament_app/const.dart';
import 'Widgets/card02.dart';
import 'Widgets/roundButton.dart';
import 'admindetails_Screen.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  String id;

  @override
  void initState() {
    super.initState();
    read('adminId').then((value) {
      setState(() {
        id = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: adminHomeContainerColor),
              ),
              roundButton(
                context: context,
                onPressed: () async {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddScreen()))
                      .then((value) => {
                            if (value) {setState(() {})}
                          });
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 50,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      remove('admin');
                      remove('adminId');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UsernameScreen()));
                    }),
              ),
            ],
          ),
          FutureBuilder<List<Tournament>>(
            future: getTournament(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error));
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        setState(() {});
                      },
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            if (snapshot.hasData &&
                                snapshot.data[i].createdBy == id) {
                              return card02(
                                  infolist: snapshot.data,
                                  index: i,
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return AdminDetailScreen(
                                        indexInfo: snapshot.data[i],
                                      );
                                    })).then((value) {
                                      if (value) {
                                        setState(() {});
                                      }
                                    });
                                  });
                            }
                            return Container();
                          }),
                    ),
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
