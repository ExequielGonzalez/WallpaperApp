import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

class SharedPref {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  static final SharedPref _instance = SharedPref._privateConstructor();

  factory SharedPref() {
    return _instance;
  }

  SharedPref._privateConstructor() {
    _getInstance();
  }

  _getInstance() async {
    _sharedPreferences = await _prefs;
  }

  addStringToSharedPreference(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }

  addIntToSharedPreference(String key, int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(key, value);
  }

  addDoubleToSharedPreference(String key, double value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setDouble(key, value);
  }

  addBoolToSharedPreference(String key, bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(key, value);
  }

  getStringValuesSharedPreference(String key) async {
    //Return String
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String stringValue = sharedPreferences.getString(key) ?? '';
    return stringValue;
  }

  getBoolValuesSharedPreference(String key) async {
    //Return bool
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool boolValue = sharedPreferences.getBool(key);
    return boolValue;
  }

  getIntValuesSharedPreference(String key) async {
    //Return int
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int intValue = sharedPreferences.getInt(key) ?? 0;
    return intValue;
  }

  getDoubleValuesSharedPreference(String key) async {
    //Return double
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    double doubleValue = sharedPreferences.getDouble(key) ?? 0.0;
    return doubleValue;
  }

  removeValues(String key) async {
    //Remove with a key
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }

  checkIfKeyIsPresent(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    bool checkValue = sharedPreferences.containsKey(key) ?? false;
    return checkValue;
  }

  saveListInt(String key, List<int> value) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stringsList = value.map((i) => i.toString()).toList();

// store your string list in shared prefs
    prefs.setStringList("banned", stringsList);
    print(stringsList);
  }

  remove(String key) async {
    _sharedPreferences.remove(key);
  }
}
