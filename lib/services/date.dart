import 'package:date_format/date_format.dart';
import 'package:wallpaper/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class Date {
  //Singleton
  String _last;

  static final Date _instance = Date._privateConstructor();

  factory Date() {
    return _instance;
  }

  Date._privateConstructor() {
    print('creando new DateSingleton');
    readDateFromDB();
  }

  bool isNewDay() {
    String today = convertDateToString();
    if (today != _last) {
      _last = today;
      SharedPref sharedPref = SharedPref();
      sharedPref.addStringToSharedPreference(kKeyDate, _last);
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

    if (!sharedPreferences.containsKey(kKeyDate)) {
      print('creando key $kKeyDate en DB');
      String today = convertDateToString();
      sharedPref.addStringToSharedPreference(kKeyDate, today);
    }

    _last = await sharedPref.getStringValuesSharedPreference(kKeyDate);
    print('la ultima foto es de $_last');
  }
}
