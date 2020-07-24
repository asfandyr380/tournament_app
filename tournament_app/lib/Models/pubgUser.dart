class User {
  String id;
  String username;
  String date;

  User({this.date, this.id, this.username});

  factory User.formJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['Username'],
      date: json['date']);
  }

  Map<String, dynamic> toJson() =>
  {
    'id': id,
    'username': username,
    'date': date
  };
}
