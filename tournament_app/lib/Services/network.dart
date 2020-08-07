import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tournament_app/Models/adminUser.dart';
import 'package:tournament_app/Models/pubgUser.dart';
import 'package:tournament_app/Models/tournament_model.dart';
import 'package:tournament_app/Services/storage.dart';
import 'package:tournament_app/const.dart';

class Network {

  // Update the Joined Player Count
Future<void> updateJoin(List list, int index, String userId) async {
  var body = {
    "joined": list[index].joined += 1,
  };
  http.Response res = await http.patch(
      '$baseUrl/tournaments/update/${list[index].id}',
      headers: header,
      body: json.encode(body));
  print(res.body);
}

// Save Current Sign In User Id to the Joined Player Array
Future<void> saveCurrentUserid(String userId, List list, int index) async {
  var body = {
    "joinedUsers": userId,
  };
  http.Response res = await http.post(
      '$baseUrl/tournaments/updatejoin/${list[index].id}',
      body: json.encode(body),
      headers: header);
  print(res.body);
}

// Save The New User or logIn the Existing One
Future<User> saveUser({String text}) async {
  String url = '$baseUrl/user';
  var body = {
    'Username': text,
  };
  http.Response res =
      await http.post(url, headers: header, body: json.encode(body));
  Map decodedata = json.decode(res.body);
  print(decodedata);
  if (res.statusCode == 200 || res.statusCode == 201) {
    save('user', decodedata['Username']);
    save('id', decodedata['_id']);
    return User.formJson(decodedata);
  } else if (res.statusCode == 400) return null;
}

// Fetch all the available Tournaments
Future<List<Tournament>> getTournament() async {
  try {
    String url = '$baseUrl/tournaments';
    var res = await http.get(url, headers: header);
    final decodedBody = json.decode(res.body).cast<Map<String, dynamic>>();
    if (res.statusCode == 200 && decodedBody != null) {
      return decodedBody
          .map<Tournament>((item) => Tournament.fromJson(item))
          .toList();
    } else {
      return throw Exception('error');
    }
  } catch (err) {
    print(err);
  }
}

// Sign In The Admin User
Future<AdminUser> signInUser(String username, String pass) async {
  String url = '$baseUrl/admin/logIn';
  var body = {'username': username, 'password': pass};
  http.Response res =
      await http.post(url, headers: header, body: json.encode(body));
  Map decodedata = json.decode(res.body);
  if (res.statusCode == 200) {
    print(decodedata);
    save('admin', decodedata['username']);
    save('adminId', decodedata['_id']);
    return AdminUser.fromJson(decodedata);
  } else if(res.statusCode == 400)
    return null;
}


// Add a Single Tournament to the Database
Future<Tournament> postTournament(
  context,
  String title,
  String roomid,
  String roomPass,
  String map,
  String type,
  TimeOfDay time,
  DateTime date,
  String id,
) async {
  String url = '$baseUrl/tournaments';
  var body = {
    'title': title,
    'roomId': roomid,
    'roomPass': roomPass,
    'joined': 0,
    'mapType': map,
    'type': type,
    'time': time.format(context),
    'date': date.toString().split(' ')[0],
    'createdBy': id
  };
  http.Response res =
      await http.post(url, headers: header, body: json.encode(body));
  Map decodedBody = json.decode(res.body);
  if (res.statusCode == 201 && decodedBody != null) {
    return Tournament.fromJson(decodedBody);
  } else {
    return null;
  }
}

  // Get the List of Joined Users array
  Future<List<UserIds>> getJoinedUsers(String id) async {
    String url = '$baseUrl/tournaments/joined/$id';
    http.Response res = await http.get(url, headers: header);
    var decodedata = json.decode(res.body).cast<Map<String, dynamic>>();
    if (res.statusCode == 200) {
      return decodedata.map<UserIds>((item) => UserIds.fromJson(item)).toList();
    } else if (res.statusCode == 400) return null;
  }

  // Delete the user from the database
  Future<String> deleteAccount(String iD) async {
    final String url = '$baseUrl/user/delete/$iD';
    http.Response res = await http.delete(url, headers: header);
    if (res.statusCode == 201) {
      return 'Success';
    } else
      return 'Error';
  }

  // Delete the tournament by Id from the Database
  Future<String> removeTournament(String id) async
  {
    final String url = '$baseUrl/tournaments/delete/$id';
    http.Response res = await http.delete(url, headers: header);
    if(res.statusCode == 201)
    {
      return 'Success';
    }else return 'Error';
  }
}