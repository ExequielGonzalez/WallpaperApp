import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper/constants.dart';
import 'package:wallpaper/services/banned_images.dart';
import 'package:wallpaper/services/can_new_photo.dart';
import 'package:wallpaper/services/date.dart';
import 'package:wallpaper/services/directory_manager.dart';
import 'package:wallpaper/services/images_manager.dart';
import 'package:wallpaper/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class Starting extends StatefulWidget {
  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
//        backgroundColor: Colors.black,

        body: Container(
          decoration: kBackgroundGradient,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitFadingCube(
//              color: Theme.of(context).accentColor,
                color: Colors.white,
                size: 50.0,
              ),
              SizedBox(height: 30),
              Text(
                "Starting...",
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
//    AdmobManager.initAdMob(); //se inician los ads

    super.initState();
    setSharedPreferences(); //I give time to read all the sharedPreferences
    setSingletons();
    Future.delayed(const Duration(seconds: 1), () {
      //after 1 second, go to /home
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  void setSingletons() {
    Future.delayed(const Duration(milliseconds: 10), () {
      //after 1 second, go to /home
      BannedImages bannedImages = BannedImages(); //Create the singleton
    });
    //after 1 second, go to /home
    Future.delayed(const Duration(milliseconds: 100), () {
      //after 1 second, go to /home
      CanNewPhoto canNewPhoto = CanNewPhoto();
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      //after 1 second, go to /home
      Date date = Date();
    });
    Future.delayed(const Duration(milliseconds: 250), () {
      //after 1 second, go to /home
      DirectoryManager directoryManager = DirectoryManager();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      //after 1 second, go to /home
      ImagesManager imagesManager = ImagesManager();
    });
  }

  void setSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    SharedPref sharedPref = SharedPref();

//    await sharedPreferences.remove(kKeyPhoto);
//    await sharedPreferences.remove(kKeyBanned);
//    await sharedPreferences.remove(kKeyNewPhotos);
//    await sharedPreferences.remove(kKeyDate);
//    await sharedPreferences.remove(kKeyPhoto);

    if (!sharedPreferences.containsKey(kKeyNewPhotos)) {
      print('creando key $kKeyNewPhotos en DB');
      sharedPref.addIntToSharedPreference(kKeyNewPhotos, kCantNewPhotos);
    }
  }
}
