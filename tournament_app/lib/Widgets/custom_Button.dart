import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.onPressed, this.lable, this.color});
  final Function onPressed;
  final String lable;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 116,
        height: 28,
        child: Center(
          child: Text(
            lable,
            style: TextStyle(fontSize: 23),
          ),
        ),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(color: Colors.black38, blurRadius: 10),
            ]),
      ),
    );
  }
}
