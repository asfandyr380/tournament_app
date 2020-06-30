class Tournament {
  String title;
  String roomID;
  String roomPass;
  String map;
  String type;
  String date;
  String time;
  int joined;

  Tournament(
      {this.date,
      this.map,
      this.roomID,
      this.roomPass,
      this.time,
      this.title,
      this.type, this.joined});
}
