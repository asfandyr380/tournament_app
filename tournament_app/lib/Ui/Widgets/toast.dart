import 'package:flutter/material.dart';

void showToast({BuildContext context, String msg}) {
  final snackBar = SnackBar(content: Text(msg));
  Scaffold.of(context).showSnackBar(snackBar);
}