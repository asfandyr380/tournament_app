import 'package:flutter/material.dart'; 

class CustomButton extends StatelessWidget {

  CustomButton({this.onPressed, this.height, this.width, this.lable, this.margin, this.color});
  final Function onPressed;
  final double width;
  final double height;
  final String lable;
  final EdgeInsetsGeometry margin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width != null ? width: 116,
        height: height != null ? height: 28,
        padding: EdgeInsets.only(left: 30),
        margin: margin,
        child: Text(
          lable,
          style: TextStyle(fontSize: 23),
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
