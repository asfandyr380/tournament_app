import 'package:flutter/material.dart';
import 'package:tournament_app/Services/network.dart';
import 'package:tournament_app/Ui/admin_Home.dart';
import 'package:tournament_app/const.dart';
import 'Widgets/custom_Button.dart';

class AdminPanal extends StatefulWidget {
  @override
  _AdminPanalState createState() => _AdminPanalState();
}

class _AdminPanalState extends State<AdminPanal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isNotEmpty = false;
  bool isLoading = false;

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
                isLoading ? CircularProgressIndicator(): Container(),
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
                    controller: usernameController,
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
                    controller: passController,
                    decoration: inputDecoration.copyWith(
                        hintText: 'Enter Password', labelText: 'Password'),
                  ),
                ),
                CustomButton(
                  margin: EdgeInsets.only(top: 20),
                  color: buttonColor,
                  lable: 'Sign In',
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (await signInUser(usernameController.text, passController.text) != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AdminHome()));
                      setState(() {
                        isNotEmpty = true;
                      });
                    }else {
                      SnackBar(content: Text('Error Sign In'));
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
