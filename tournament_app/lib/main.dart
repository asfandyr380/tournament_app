import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Ui/home.dart';
import 'Ui/username_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _pref = await SharedPreferences.getInstance();
  var username = _pref.getString('user');
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    home: username == null ? UsernameScreen(): Home(),
  ));
}
