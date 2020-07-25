import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tournament_app/Models/adminUser.dart';
import 'package:tournament_app/Models/pubgUser.dart';
import 'package:tournament_app/Models/tournament_model.dart';
import 'package:tournament_app/Services/storage.dart';
import 'package:tournament_app/const.dart';

// Update the Joined Player Count
Future<void> updateJoin(List list, int index, String userId) async {
  var header = {'Content-Type': 'application/json; charset=UTF-8'};
  var body = {
    "joined": list[index].joined += 1,
  };
  http.Response res = await http.patch(
      '$baseUrl/tournaments/update/${list[index].id}',
      headers: header,
      body: json.encode(body));
  print(res.body);
}

Future<void> saveCurrentUserid(String userId, List list, int index) async
{
    var header = {'Content-Type': 'application/json; charset=UTF-8'};
  var body = {
    "joinedUsers": userId,
  };
  http.Response res = await http.post('$baseUrl/tournaments/updatejoin/${list[index].id}', body: json.encode(body), headers: header);
  print(res.body);
}

// Save The New User
Future<User> saveUser({String text}) async {
  String url = '$baseUrl/user';
  var header = {'Content-Type': 'application/json; charset=UTF-8'};
  var body = {
    'Username': text,
  };
  http.Response res =
      await http.post(url, headers: header, body: json.encode(body));
  Map decodedata = json.decode(res.body);
  if(decodedata != null)
  { 
    save('user', decodedata['Username']);
    save('id', decodedata['_id']);
    return User.formJson(decodedata);
  } 
  return null;
}


Future<List<Tournament>> getTournament() async {
    String url = '$baseUrl/tournaments';
    var res = await http.get(url);
    final decodedBody = json.decode(res.body).cast<Map<String, dynamic>>();
    if (res.statusCode == 200 && decodedBody != null) {
      return decodedBody.map<Tournament>((item) => Tournament.fromJson(item)).toList();
    } else {
      return throw Exception('error');
    }
  }


  Future<AdminUser> signInUser(String username, String pass) async {
    String url = '$baseUrl/admin/logIn';
    var header = {'Content-Type': 'application/json; charset=UTF-8'};
    var body = {
      'username': username,
      'password': pass
    };
    http.Response res =
        await http.post(url, headers: header, body: json.encode(body));
    Map decodedata = json.decode(res.body);    
    if (res.statusCode == 200 && decodedata != null) {
      print(decodedata);
      save('admin', decodedata['username']);
      save('adminId', decodedata['_id']);
      return AdminUser.fromJson(decodedata);
    }
    return throw Exception('Error with Sign In');
  }