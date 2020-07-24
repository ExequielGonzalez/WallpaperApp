import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper/constants.dart';
import 'package:wallpaper/services/banned_images.dart';
import 'package:wallpaper/services/can_new_photo.dart';
import 'package:wallpaper/services/date.dart';
import 'package:wallpaper/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    Future.delayed(const Duration(seconds: 1), () {
      //after 1 second, go to /home
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  void setSharedPreferences() async {
    BannedImages bannedImages = BannedImages(); //Create the singleton
    CanNewPhoto canNewPhoto = CanNewPhoto();
    Date date = Date();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    SharedPref sharedPref = SharedPref();

//    sharedPreferences.remove(kKeyBanned);
//    sharedPreferences.remove(kKeyNewPhotos);
//    sharedPreferences.remove(kKeyDate);

    if (!sharedPreferences.containsKey(kKeyNewPhotos)) {
      sharedPref.addIntToSharedPreference(kKeyNewPhotos, kCantNewPhotos);
    }
  }
}
