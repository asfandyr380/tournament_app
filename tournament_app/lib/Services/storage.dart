import 'package:shared_preferences/shared_preferences.dart';

save(String key, String value) async{
  SharedPreferences _pref = await SharedPreferences.getInstance();
  _pref.setString(key, value);
}

read(String key) async{
  SharedPreferences _pref = await SharedPreferences.getInstance();
  return _pref.getString(key);
}

remove(String key) async{
  SharedPreferences _pref = await SharedPreferences.getInstance();
  _pref.remove(key);
}