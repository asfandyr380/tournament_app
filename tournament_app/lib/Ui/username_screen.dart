import 'package:flutter/material.dart';
import 'package:tournament_app/Services/connectivity.dart';
import 'package:tournament_app/Services/network.dart';
import 'package:tournament_app/Ui/admin_panal.dart';
import 'package:tournament_app/const.dart';
import 'Widgets/custom_Button.dart';
import 'home.dart';

final TextEditingController _controller = TextEditingController();

class UsernameScreen extends StatefulWidget {
  @override
  _UsernameScreenState createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isNotEmpty = false;
  bool isLoading = false;


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          autovalidate: isNotEmpty,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              isLoading
                  ? Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: LinearProgressIndicator())
                  : Container(),
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
              CustomButton(
                color: buttonColor,
                lable: 'Save',
                onPressed: () async {
                  try {
                    FocusScope.of(context).unfocus();
                      if (_formKey.currentState.validate()) {
                        if(await checkConnectivity(context))
                        setState(() {
                          isLoading = true;
                        });
                        var notNull = await saveUser(text: _controller.text);
                        if (notNull != null) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
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
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminPanal()));
                },
                child: Container(
                  child: Text('Admin Panal',
                      style:
                          TextStyle(color: adminPanalTextColor, fontSize: 25)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}