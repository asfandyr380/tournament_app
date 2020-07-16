import 'package:flutter/material.dart';
import 'package:tournament_app/Ui/Add_Screen.dart';
import 'package:tournament_app/const.dart';


class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddScreen()));
                },
              ),
            ],
          ),
          Expanded(child: ListView.builder(itemBuilder: (context, i) {}))
        ],
      ),
    );
  }
}

Widget roundButton({context, Function onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 70,
      width: 70,
      margin: EdgeInsets.only(
          top: 120, left: MediaQuery.of(context).size.width * 0.4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: buttonColor,
      ),
    ),
  );
}
