import 'dart:convert';
import 'package:tournament_app/Models/tournament_model.dart';
import 'package:http/http.dart' as http;

List<Tournament> list = [];

Future<List<Tournament>> getTournament() async {
  var res = await http.get('http://192.168.10.6:3000/tournaments');
  var jsondata = json.decode(res.body);

  for (var data in jsondata) {
    Tournament info = Tournament(
        date: data['date'],
        time: data['time'],
        roomID: data['roomId'],
        roomPass: data['roomPass'],
        joined: data['joined'],
        map: data['mapType'],
        title: data['title'],
        type: data['type']);
        
    list.add(info);
  }
  print(list.length);
  return list;
}
