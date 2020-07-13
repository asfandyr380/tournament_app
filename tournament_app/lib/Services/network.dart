import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tournament_app/Models/pubgUser.dart';


User newUser;

// Update the Joined Player Count
Future<void> updateJoin(var join, String id) async {
  var header = {'Content-Type': 'application/json; charset=UTF-8'};
  var body = {
    "joined": join,
  };
  http.Response res = await http.patch(
      'http://192.168.10.5:3000/tournaments/updateOne/$id',
      headers: header,
      body: json.encode(body));
  print(res.body);
}

// Save The New User
Future<void> saveUser(String text) async {
  String url = 'http://192.168.10.5:3000/user';
  var header = {'Content-Type': 'application/json; charset=UTF-8'};
  var body = {
    'PubgUsername': text,
  };
  http.Response res =
      await http.post(url, headers: header, body: json.encode(body));
  var jbody = json.decode(res.body);

  for (var jdata in jbody) {
    User user = User(
      id: jdata['_id'],
      username: jdata['PubgUsername'],
      date: jdata['Date'],
    );
    newUser = user;
  }
}
