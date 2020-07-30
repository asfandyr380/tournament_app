
class Tournament {
  String id;
  String title;
  String roomID;
  String roomPass;
  String map;
  String type;
  String date;
  String time;
  int joined;
  String createdBy;
  List<String> joinedUsers;

  Tournament(
      {this.createdBy,
      this.joinedUsers,
      this.id,
      this.date,
      this.map,
      this.roomID,
      this.roomPass,
      this.time,
      this.title,
      this.type,
      this.joined});

  factory Tournament.fromJson(Map<String, dynamic> json) {
    List list = json['joinedUsers'];
    List<String> userList = new List<String>.from(list);

    return Tournament(
        id: json['_id'],
        title: json['title'],
        roomID: json['roomId'],
        roomPass: json['roomPass'],
        map: json['mapType'],
        type: json['type'],
        date: json['date'],
        time: json['time'],
        joined: json['joined'],
        createdBy: json['createdBy'],
        joinedUsers: userList);
  }
}

class UserIds {
  String userId;
  String username;
  UserIds({this.userId, this.username});

  factory UserIds.fromJson(Map<String, dynamic> parsedJson) {
    return UserIds(userId: parsedJson['\$oid'],
    username: parsedJson['Username']);
  }
}
