import 'package:flutter/material.dart';
import 'package:tournament_app/const.dart';
import 'Widgets/custom_Button.dart';
import 'home.dart';

class UsernameScreen extends StatefulWidget {
  @override
  _UsernameScreenState createState() => _UsernameScreenState();
}

final _formKey = GlobalKey<FormState>();

class _UsernameScreenState extends State<UsernameScreen> {
  bool isNotEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Text(
              'Tournament',
              style: TextStyle(
                fontSize: 54,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              autovalidate: isNotEmpty,
              key: _formKey,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Username';
                }
                return null;
              },
              decoration: inputDecoration,
            ),
          ),
          CustomButton(
            onPressed: () {
              setState(() {
                isNotEmpty = true;
              });
              if (_formKey.currentState.validate()) {
                // TODO: Save the Username and Never Show the Screen again
              }
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            child: Container(
              child: Text('Admin Panal',
                  style: TextStyle(color: adminPanalTextColor, fontSize: 25)),
            ),
          ),
        ],
      ),
    );
  }
}
