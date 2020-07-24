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
  List joinedUsers;
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
      joinedUsers: json['JoinedUsers'],
    );
  }
}
