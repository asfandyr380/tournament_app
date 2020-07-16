class User 
{
  String id;
  String username;
  String date;

  User({this.date,this.id,this.username});

  User.formJson(Map<String, dynamic> json)
  {
    id = json['id'];
    username = json['username'];
    date = json['date'];
  }

  Map<String, dynamic> toJson()
  {
   final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['date'] = this.date;
    return data;
  }
  


}