import 'package:flutter/material.dart';
import 'package:tournament_app/Models/tournament_model.dart';
import 'package:tournament_app/Services/network.dart';
import 'package:tournament_app/Services/storage.dart';
import 'package:tournament_app/Ui/Add_Screen.dart';
import 'package:tournament_app/const.dart';
import 'Widgets/card02.dart';
import 'Widgets/roundButton.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  bool isAdded;
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
        mainAxisAlignment: MainAxisAlignment.center,
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
                  isAdded = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddScreen()));
                },
              ),
            ],
          ),
          FutureBuilder<List<Tournament>>(
            future: getTournament(),
            builder: (context, snapshot) {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    if(snapshot.hasData && snapshot.data[i].createdBy == id)
                    {
                      return card02(infolist: snapshot.data, index: i);
                    }
                    return Container();
                  }
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
