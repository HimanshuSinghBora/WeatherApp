import 'package:shared_preferences/shared_preferences.dart';


class Helper {

  static String valueSharedPreferences = 'cityName';

// Write DATA

  static Future<bool> saveUserData(value) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return await sharedPreferences.setString(valueSharedPreferences, value);

  }


// Read Data

  static Future getUserData() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString(valueSharedPreferences);

  }
}