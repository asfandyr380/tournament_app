
import 'package:flutter/material.dart';
import 'package:tournament_app/Services/connectivity.dart';
import 'package:tournament_app/Services/network.dart';
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgorundColor,
      body: Builder(
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
                  margin: EdgeInsets.only(top: 40, left:58),
                  child: Text(
                    'Tournament',
                    style: TextStyle(
                      fontSize: 54,
                    ),
                  ),
                ),
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
              ),
              Container(
                margin: EdgeInsets.only(top: 223),
                height: height * 0.1,
                width: width * 1,
                child: CustomPaint(
                  painter: BottomStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class BottomStyle extends CustomPainter{
  @override
  void paint(Canvas canva  , Size size) {
    var width = size.width;
    var height = size.height;
      Path path = Path();
      Paint paint = Paint();
      
      path.addRect(Rect.fromLTRB(0, 0, width, height));
      path.moveTo(width * 0.40, 0);
      path.quadraticBezierTo(width * 0.50, height * 0.60, width * 0.60, 0);
      paint.color = Color(0xff41CDD5);
      canva.drawPath(path, paint);


    }
  

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
  
}




class CurvePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
  Path path = Path();
  Paint paint = Paint();


  path.lineTo(0, size.height *0.75);
  path.quadraticBezierTo(size.width* 0.10, size.height*0.70,   size.width*0.17, size.height*0.90);
  path.quadraticBezierTo(size.width*0.20, size.height, size.width*0.25, size.height*0.90);
  path.quadraticBezierTo(size.width*0.40, size.height*0.40, size.width*0.50, size.height*0.70);
  path.quadraticBezierTo(size.width*0.60, size.height*0.85, size.width*0.65, size.height*0.65);
  path.quadraticBezierTo(size.width*0.70, size.height*0.90, size.width, 0);
  path.close();

  paint.color = Color(0x5041CDD5);
  canvas.drawPath(path, paint); 

  path = Path();
  path.lineTo(0, size.height*0.50);
  path.quadraticBezierTo(size.width*0.10, size.height*0.80, size.width*0.15, size.height*0.60);
  path.quadraticBezierTo(size.width*0.20, size.height*0.45, size.width*0.27, size.height*0.60);
  path.quadraticBezierTo(size.width*0.45, size.height, size.width*0.50, size.height*0.80);
  path.quadraticBezierTo(size.width*0.55, size.height*0.45, size.width*0.75, size.height*0.75);
  path.quadraticBezierTo(size.width*0.85, size.height*0.93, size.width, size.height*0.60);
  path.lineTo(size.width, 0);
  path.close();

  paint.color = Color(0x9941CDD5);
  canvas.drawPath(path, paint);

  path =Path();
  path.lineTo(0, size.height*0.80);
  path.quadraticBezierTo(size.width*0.10, size.height*0.55, size.width*0.21, size.height*0.70);
  path.quadraticBezierTo(size.width*0.30, size.height*0.90, size.width*0.40, size.height*0.75);
  path.quadraticBezierTo(size.width*0.52, size.height*0.50, size.width*0.65, size.height*0.70);
  path.quadraticBezierTo(size.width*0.75, size.height*0.85, size.width, size.height*0.60);
  path.lineTo(size.width, 0);
  path.close();

  paint.color = Color(0xff41CDD5);
  canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}
