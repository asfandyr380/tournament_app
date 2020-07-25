import 'package:flutter/material.dart';
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

final _formKey = GlobalKey<FormState>();

class _UsernameScreenState extends State<UsernameScreen> {
  bool isNotEmpty = false;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
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
                controller: _controller,
                autovalidate: isNotEmpty,
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
              onPressed: () {
                setState(() {
                  isNotEmpty = true;
                });
                try {
                  if (_formKey.currentState.validate()) {
                    saveUser(text:_controller.text).whenComplete(() async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                            _controller.clear();
                    });
                  }
                } catch (error) {
                  print(error);
                }
              },
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AdminPanal()));
              },
              child: Container(
                child: Text('Admin Panal',
                    style: TextStyle(color: adminPanalTextColor, fontSize: 25)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
