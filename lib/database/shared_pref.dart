import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences sharedPreferences;

  static sharedDefinition() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static putData(String key, dynamic value) async {
    if (value is bool) {
      sharedPreferences.setBool(key, value);
      print('bool data putted');
    }

    if (value is String) {
      sharedPreferences.setString(key, value);
      print('bool data putted');
    }

    if (value is int) {
      sharedPreferences.setInt(key, value);
      print('int data putted');
    }

    if (value is double) {
      sharedPreferences.setDouble(key, value);
      print('double data putted');
    }
  }

  static getData(String key) {
    return sharedPreferences.get(key);
  }

  static removeData(String key) {
    return sharedPreferences.remove(key);
  }
}
