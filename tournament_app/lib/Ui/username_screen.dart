import 'package:flutter/material.dart';
import 'package:tournament_app/Services/connectivity.dart';
import 'package:tournament_app/Services/network.dart';
import 'package:tournament_app/Ui/admin_panal.dart';
import 'package:tournament_app/Widgets/Style.dart';
import 'package:tournament_app/Widgets/custom_Button.dart';
import 'package:tournament_app/const.dart';
import 'home.dart';

class UsernameScreen extends StatefulWidget {
  @override
  _UsernameScreenState createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  Network _network = Network();
  bool isNotEmpty = false;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
              key: _formKey,
              autovalidate: isNotEmpty,
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
                    margin: EdgeInsets.only(top: 60, left: 10, right: 10),
                    child: TextFormField(
                      controller: _controller,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Username';
                        }
                        return null;
                      },
                      decoration: inputDecoration,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: CustomButton(
                      color: buttonColor,
                      lable: 'Save',
                      onPressed: () async {
                        try {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState.validate()) {
                            if (await checkConnectivity(context))
                              setState(() {
                                isLoading = true;
                              });
                            var notNull =
                                await _network.saveUser(text: _controller.text);
                            if (notNull != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                              _controller.clear();
                            } else {
                              setState(() {
                                isLoading = false;
                                isNotEmpty = true;
                              });
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Server Error'),
                              ));
                            }
                          }
                        } catch (error) {
                          print(error);
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 154),
                    height: height * 0.2,
                    width: width * 1,
                    child: CustomPaint(
                      painter: BottomStyle(),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminPanal()));
                        },
                        child: Container(
                            margin: EdgeInsets.only(bottom: 25),
                            child:
                                Icon(Icons.supervised_user_circle, size: 50)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
