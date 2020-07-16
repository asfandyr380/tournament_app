import 'enroll.dart';

class Tournament {
  Enrolled enroll;
  String id;
  String title;
  String roomID;
  String roomPass;
  String map;
  String type;
  String date;
  String time;
  int joined;
  bool isJoined;

  Tournament(
      {this.enroll,
      this.isJoined,
      this.id,
      this.date,
      this.map,
      this.roomID,
      this.roomPass,
      this.time,
      this.title,
      this.type,
      this.joined});
}
