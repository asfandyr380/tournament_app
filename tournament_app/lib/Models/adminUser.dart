class AdminUser {
  String id;
  String username;

  AdminUser({this.id, this.username});

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      id: json['_id'],
     username: json['username']);
  }
}
