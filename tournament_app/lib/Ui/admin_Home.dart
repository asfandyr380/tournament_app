import 'package:flutter/material.dart';
import 'package:tournament_app/Ui/Add_Screen.dart';
import 'package:tournament_app/const.dart';
import 'Widgets/card02.dart';
import 'Widgets/roundButton.dart';

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
        ],
      ),
    );
  }
}


// Expanded(
//             child: ListView.builder(
//               itemCount: infoList.length,
//               itemBuilder: (context, i) {
//                 return card02(infolist: infoList, index: i);
//               },
//             ),
//           ),
