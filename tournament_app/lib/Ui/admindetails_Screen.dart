import 'package:flutter/material.dart';
import 'package:tournament_app/Models/tournament_model.dart';
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
        child: FutureBuilder(
          future: getJoinedUsers(indexInfo.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: indexInfo.joinedUsers.length,
                  itemBuilder: (context, i) {
                    return Center(child: Text(snapshot.data[i].username));
                  });
            } return CircularProgressIndicator();
          } 
        ),
      ),
    );
  }
}
