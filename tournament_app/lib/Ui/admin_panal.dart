import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tournament_app/Models/adminUser.dart';
import 'package:tournament_app/Ui/admin_Home.dart';
import 'package:tournament_app/const.dart';
import 'Widgets/custom_Button.dart';
import 'package:http/http.dart' as http;

class AdminPanal extends StatefulWidget {
  @override
  _AdminPanalState createState() => _AdminPanalState();
}

class _AdminPanalState extends State<AdminPanal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController username_Controller = TextEditingController();
  final TextEditingController pass_Controller = TextEditingController();
  bool isNotEmpty = false;
  AdminUser newUser;
  bool successlogin;

  Future<void> signInUser() async {
    String url = 'http://192.168.10.5:3000/admin/logIn';
    var header = {'Content-Type': 'application/json; charset=UTF-8'};
    var body = {
      'username': username_Controller.text,
      'password': pass_Controller.text
    };
    http.Response res =
        await http.post(url, headers: header, body: json.encode(body));
        
    if (res.statusCode == 200) {
      var jbody = json.decode(res.body);
      print(jbody);
      for (var jdata in jbody) {
        AdminUser newAdminUser = AdminUser(
          id: jdata['_id'],
          username: jdata['username'],
          password: jdata['password'],
        );
        newUser = newAdminUser;
      }
      successlogin = true;
    } else if (res.statusCode == 400) {
      successlogin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Form(
          autovalidate: true,
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Tournament',
                    style: TextStyle(
                      fontSize: 54,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: TextFormField(
                    autovalidate: isNotEmpty,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please Enter a Valid Usename';
                      }
                      return null;
                    },
                    controller: username_Controller,
                    decoration: inputDecoration.copyWith(
                        hintText: 'Enter Username', labelText: 'Username'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    autovalidate: isNotEmpty,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please Enter a Valid Password';
                      }
                      return null;
                    },
                    controller: pass_Controller,
                    decoration: inputDecoration.copyWith(
                        hintText: 'Enter Password', labelText: 'Password'),
                  ),
                ),
                CustomButton(
                  margin: EdgeInsets.only(top: 20),
                  color: buttonColor,
                  lable: 'Sign In',
                  onPressed: () async {
                    await signInUser();
                    if (successlogin == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AdminHome()));
                    }else {
                      print('Invalid Information');
                    }
                    setState(() {
                      isNotEmpty = true;
                    });
                  },
                ),
              ],
            ),
          )),
    );
  }
}
