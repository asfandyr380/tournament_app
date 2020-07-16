import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/Models/pubgUser.dart';

User newUser;

// Update the Joined Player Count
Future<void> updateJoin(List list, int index) async {
  var header = {'Content-Type': 'application/json; charset=UTF-8'};
  var body = {
    "joined": list[index].joined += 1,
  };
  http.Response res = await http.patch(
      'http://192.168.10.5:3000/tournaments/updateOne/${list[index].id}',
      headers: header,
      body: json.encode(body));
  print(res.body);
}

// Save The New User
Future<User> saveUser(String text) async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String url = 'http://192.168.10.4:3000/user';
  var header = {'Content-Type': 'application/json; charset=UTF-8'};
  var body = {
    'PubgUsername': text,
  };
  http.Response res =
      await http.post(url, headers: header, body: json.encode(body));
  Map decodedata = json.decode(res.body);
  if(decodedata != null)
  {
    String user = jsonEncode(User.formJson(decodedata));
    _pref.setString('newUser', user);
    return User.formJson(decodedata);
  } 
  return null;
}

Future<User> getSavedInfo()async{
 SharedPreferences preferences = await SharedPreferences.getInstance();
 Map userMap = jsonDecode(preferences.getString('newUser'));
  User user = User.formJson(userMap);
  return user;
 }
