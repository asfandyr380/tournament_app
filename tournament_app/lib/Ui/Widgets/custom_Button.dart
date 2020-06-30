import 'package:flutter/material.dart';
import '../../const.dart';

class CustomButton extends StatelessWidget {

  CustomButton({this.onPressed});
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 116,
        height: 28,
        padding: EdgeInsets.only(left: 30),
        child: Text(
          'Save',
          style: TextStyle(fontSize: 23),
        ),
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(color: Colors.black38, blurRadius: 10),
            ]),
      ),
    );
  }
}
