import 'package:date_format/date_format.dart';
import 'package:wallpaper/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Date {
  //Singleton
  String _last;

  static final Date _instance = Date._privateConstructor();

  factory Date() {
    return _instance;
  }

  Date._privateConstructor() {
    readDateFromDB();
  }

  bool isNewDay() {
    String today = convertDateToString();
    if (today != _last) {
      _last = today;
      SharedPref sharedPref = SharedPref();
      sharedPref.addStringToSharedPreference('date', _last);
      return true;
    }
    return false;
  }

  String convertDateToString() {
    final todayDate = DateTime.now();
    String today = formatDate(todayDate, [yyyy, '-', mm, '-', dd]);
    print(today);
    return today;
  }

  void convertStringToDate(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    print(todayDate);
    print(formatDate(todayDate, [yyyy, '-', mm, '-', dd]));
  }

  readDateFromDB() async {
    SharedPref sharedPref = SharedPref();
    SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance(); //TODO:clean code

    if (!sharedPreferences.containsKey('date')) {
      String today = convertDateToString();
      sharedPref.addStringToSharedPreference('date', today);
    }
    _last = await sharedPref.getStringValuesSharedPreference('date');
  }
}
