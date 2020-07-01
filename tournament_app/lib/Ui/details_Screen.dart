import 'package:flutter/material.dart';
import 'package:tournament_app/const.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50, left: 20),
            child: Text(
              'Room ID',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 134,
            height: 35,
            margin: EdgeInsets.only(left: 10),
            child: Card(
              elevation: 5,
              color: cardColor,
              child: Text(
                '1232',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
