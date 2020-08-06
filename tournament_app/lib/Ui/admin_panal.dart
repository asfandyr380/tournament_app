import 'package:flutter/material.dart';
import 'package:tournament_app/Services/connectivity.dart';
import 'package:tournament_app/Services/network.dart';
import 'package:tournament_app/Ui/Widgets/toast.dart';
import 'package:tournament_app/Ui/admin_Home.dart';
import 'package:tournament_app/Ui/username_screen.dart';
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgorundColor,
      body: SingleChildScrollView(
        child: Container(
          child: Builder(
            builder: (context) => Form(
                autovalidate: isNotEmpty,
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Stack(children: [
                          Container(
                            height: height * 0.3,
                            width: width * 1,
                            child: CustomPaint(
                              painter: CurvePainter(),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40, left: 58),
                            child: Text(
                              'Tournament',
                              style: TextStyle(
                                fontSize: 54,
                              ),
                            ),
                          ),
                          isLoading ? LinearProgressIndicator() : Container(),
                        ]),
                        Container(
                          margin: EdgeInsets.only(
                              top: 80, left: 10, right: 10, bottom: 20),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'please Enter a Valid Usename';
                              }
                              return null;
                            },
                            controller: usernameController,
                            decoration: inputDecoration.copyWith(
                                hintText: 'Enter Username',
                                labelText: 'Username'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'please Enter a Valid Password';
                              }
                              return null;
                            },
                            controller: passController,
                            decoration: inputDecoration.copyWith(
                                hintText: 'Enter Password',
                                labelText: 'Password'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: CustomButton(
                            color: buttonColor,
                            lable: 'Sign In',
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState.validate()) {
                                if (await checkConnectivity(context))
                                  setState(() {
                                    isLoading = true;
                                  });
                                if (await signInUser(usernameController.text,
                                        passController.text) !=
                                    null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdminHome()));
                                  setState(() {
                                    isLoading = false;
                                    isNotEmpty = true;
                                  });
                                } else {
                                  showToast(
                                      context: context,
                                      msg: 'Invalid Information');
                                  setState(() {
                                    isNotEmpty = true;
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
