import 'dart:convert';
import 'package:wallpaper/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class BannedImages {
  //Singleton
  List<int> _bannedImages;

  static final BannedImages _instance = BannedImages._privateConstructor();

  factory BannedImages() {
    return _instance;
  }

  BannedImages._privateConstructor() {
    _bannedImages = [];

//    while (_bannedImages.isEmpty) {
    setSharedPreferences();
    readListFromDB();
//    print('currently banned: $_bannedImages');
//    }
  }

  void setSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    sharedPreferences.remove('banned');
    if (!sharedPreferences.containsKey(kKeyBanned)) {
      print('creando key $kKeyBanned en DB');
      banImage(515);
      banImage(1667);
      banImage(1848);
      banImage(800);
      banImage(902);
      banImage(1978);
      banImage(2037);
      banImage(2072);
      banImage(1428);
      banImage(2000);
      banImage(603);
      banImage(1105);
      banImage(325);
      banImage(1524);
      banImage(839);
      banImage(99);
      banImage(865);
      banImage(394);
      banImage(1211);
      banImage(2010);
      banImage(378);
      banImage(1994);
      banImage(1965);
      banImage(589);
      banImage(594);
      banImage(1);

      saveListInDB();
    }
    banImage(int.parse(lastBanned()));
  }

  readListFromDB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> mList = (prefs.getStringList(kKeyBanned) ?? List<String>());

    _bannedImages = mList.map((i) => int.parse(i)).toList();

    print(_bannedImages);
  }

  saveListInDB() async {
    SharedPref sharedPref = SharedPref();
    sharedPref.saveListInt(kKeyBanned, _bannedImages);
  }

  void banImage(int img) async {
    if (!isBanned(img)) {
      _bannedImages.add(img);
      print('the image $img was banned');
      saveListInDB();
    }
  }

  bool isBanned(int img) {
    print('currently banned: $_bannedImages');

    return _bannedImages.contains(img);
  }

  String lastBanned() {
    return _bannedImages.last.toString();
  }
}
