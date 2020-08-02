import 'package:wallpaper/services/shared_preferences.dart';

import '../constants.dart';

class CanNewPhoto {
  //Singleton

  static final CanNewPhoto _instance = CanNewPhoto._privateConstructor();

  factory CanNewPhoto() {
    return _instance;
  }

  CanNewPhoto._privateConstructor() {
    getCantNewPhotos();
  }

  int _cantNewPhotos;

  int get cantNewPhotos => _cantNewPhotos;

  bool canGetNewPhoto() {
    if (_cantNewPhotos > 0) {
      return true;
    } else
      return false;
  }

  getCantNewPhotos() async {
    SharedPref sharedPref = SharedPref();
    _cantNewPhotos =
        await sharedPref.getIntValuesSharedPreference(kKeyNewPhotos);
  }

  void reduceCantPhotos() async {
    _cantNewPhotos -= 1;
    SharedPref sharedPref = SharedPref();
    sharedPref.addIntToSharedPreference(kKeyNewPhotos, _cantNewPhotos);
  }

  void addCantPhotos(int cant) async {
    _cantNewPhotos += cant;
    SharedPref sharedPref = SharedPref();
    sharedPref.addIntToSharedPreference(kKeyNewPhotos, _cantNewPhotos);
  }
}
