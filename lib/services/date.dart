import 'package:date_format/date_format.dart';
import 'package:wallpaper/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Date {
  //Singleton
  String _today;
  String _last;

  static final Date _instance = Date._privateConstructor();

  factory Date() {
    return _instance;
  }

  Date._privateConstructor() {
    _today = convertDateToString();
    readDateFromDB();
  }

  bool isNewDay() {
    if (_today != _last) {
      _last = _today;
      SharedPref sharedPref = SharedPref();
      sharedPref.addStringToSharedPreference('date', _today);
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
      sharedPref.addStringToSharedPreference('date', _today);
    }
    _last = await sharedPref.getStringValuesSharedPreference('date');
  }
}
