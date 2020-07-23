import 'package:wallpaper/services/shared_preferences.dart';

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

  int get cantNewPhotos => _cantNewPhotos + 1;

  bool canGetNewPhoto() {
    if (_cantNewPhotos > 0) {
      _reduceCantPhotos();
      return true;
    } else
      return false;
  }

  getCantNewPhotos() async {
    SharedPref sharedPref = SharedPref();
    _cantNewPhotos =
        await sharedPref.getIntValuesSharedPreference('cantNewPhotos');
  }

  void _reduceCantPhotos() async {
    _cantNewPhotos -= 1;
    SharedPref sharedPref = SharedPref();
    sharedPref.addIntToSharedPreference('cantNewPhotos', _cantNewPhotos);
  }
}
