import 'package:flutter/material.dart';
import 'package:tournament_app/Models/tournament_model.dart';
import 'package:tournament_app/Services/connectivity.dart';
import 'package:tournament_app/const.dart';
import 'package:tournament_app/Services/network.dart';

class AdminDetailScreen extends StatelessWidget {
  final Tournament indexInfo;

  AdminDetailScreen({this.indexInfo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Center(
        child: Builder(
          builder: (context) => Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: GestureDetector(
                        onTap: () async {
                          if(await checkConnectivity(context))
                          await delete(indexInfo.id);
                          Navigator.pop(context, true);
                        },
                        child: Text(
                          'Remove',
                          style: TextStyle(fontSize: 25, color: Colors.red),
                        )),
                  ),
                ],
              ),
              FutureBuilder(
                  future: getJoinedUsers(indexInfo.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: indexInfo.joinedUsers.length,
                            itemBuilder: (context, i) {
                              return Center(
                                  child: Text(snapshot.data[i].username));
                            }),
                      );
                    }
                    return CircularProgressIndicator();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
