import 'package:wallpaper/constants.dart';
import 'package:wallpaper/services/banned_images.dart';
import 'package:wallpaper/services/can_new_photo.dart';
import 'package:wallpaper/services/date.dart';
import 'package:wallpaper/services/images.dart';
import 'package:wallpaper/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper/services/web_images.dart' as WebImage;
import 'dart:convert';

class ImagesManager {
  //Singleton
  String _lastPhoto;
  PhotosModel _photo;
  int asd;

  static final ImagesManager _instance = ImagesManager._privateConstructor();

  factory ImagesManager() {
    return _instance;
  }

  ImagesManager._privateConstructor() {
    print('construyendo imagesManager');
    asd = 50;

    _readImageFromDB();
    processPhoto();
  }

  PhotosModel getPhoto({bool force = false, bool process = true, String id}) {
    if (process) processPhoto(forced: force);
    if (id != null) getPhotoById(id);
    return _photo;
  }

  _readImageFromDB() async {
    SharedPref sharedPref = SharedPref();
    SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance(); //TODO:clean code
    print('aca entra?');
    if (!sharedPreferences.containsKey(kKeyPhoto)) {
      print('creando key $kKeyPhoto en DB');

      await sharedPref.addStringToSharedPreference(
          kKeyPhoto, json.encode(_default));
    }
    _lastPhoto = sharedPreferences.getString(kKeyPhoto);
  }

  void processPhoto({bool forced = false}) async {
//    photo = WebImage.getTrendingWallpaper();
//    Map<String, dynamic> photoAsMap;
    Date date = Date();
    if (date.isNewDay()) {
//      photoAsMap = WebImage.getSpecificWallpaperByPage(topic: kTopic);
      Map<String, dynamic> prueba;
      prueba = await WebImage.getSpecificWallpaperByPage(topic: kTopic);
      _lastPhoto = json.encode(prueba);
      _photo = PhotosModel.fromJson(json.decode(_lastPhoto));
      SharedPref sharedPref = SharedPref();
      print('espero que entre aca');
      sharedPref.addStringToSharedPreference(kKeyPhoto, _lastPhoto);
    } else {
      if (forced) {
        CanNewPhoto canNewPhoto = CanNewPhoto();
        if (canNewPhoto.canGetNewPhoto()) {
          print(
              'This is not a new day, but also you can already get ${canNewPhoto.cantNewPhotos} awesome wallpapers...');

          Map<String, dynamic> prueba;
          prueba = await WebImage.getSpecificWallpaperByPage(topic: kTopic);
          _lastPhoto = json.encode(prueba);
          SharedPref sharedPref = SharedPref();
          print('espero que entre aca');
          sharedPref.addStringToSharedPreference(kKeyPhoto, _lastPhoto);
        }
      } else {
        print('entrandoooooooooooooooooo');
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance(); //TODO:clean code
        _lastPhoto = sharedPreferences.getString(kKeyPhoto);
      }
      print('this is not a new day...');
      Future.delayed(Duration(milliseconds: asd), () {
        print(asd);
        //after 1 second, go to /home
        (_lastPhoto == null) ? _readImageFromDB() : asd = 50;
//        _lastPhoto = _lastPhoto.replaceAll(RegExp(r"\\"), " ");
        print(_lastPhoto);

        Map<String, dynamic> prueba;
        prueba = jsonDecode(_lastPhoto);
        print(prueba);
        _photo = PhotosModel.fromJson(prueba);
      });
//      print(_lastPhoto);
//      _photo = PhotosModel.fromMap(json.decode(_lastPhoto));

//      _photo = PhotosModel.fromMap(json.decode(_default));
    }
  }

  void getPhotoById(String id) async {
    print('the id is: $id');
    Map<String, dynamic> prueba;
    prueba = await WebImage.getSpecificWallpaperById(id: id);
    _lastPhoto = json.encode(prueba);
//    _photo = PhotosModel.fromJson(json.decode(_lastPhoto));
    SharedPref sharedPref = SharedPref();
    sharedPref.addStringToSharedPreference(kKeyPhoto, _lastPhoto);

    prueba = jsonDecode(_lastPhoto);
    print(prueba);
    _photo = PhotosModel.fromJson(prueba);

//          photo = WebImage.getSpecificWallpaperById(id: id);
  }

  String _default =
      '{"id":"2508386","width":"3024","height":"4032","url":"https://www.pexels.com/photo/tabby-cat-lying-on-wooden-window-2508386/","photographer":"Utku Koylu","photographer_url":"https://www.pexels.com/@utkukoylu, photographer_id: 1308416","src":{"original":"https://images.pexels.com/photos/2508386/pexels-photo-2508386.jpeg","large2x":"https://images.pexels.com/photos/2508386/pexels-photo-2508386.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940","large":"https://images.pexels.com/photos/2508386/pexels-photo-2508386.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"," medium":"https://images.pexels.com/photos/2508386/pexels-photo-2508386.jpeg?auto=compress&cs=tinysrgb&h=350","small":"https://images.pexels.com/photos/2508386/pexels-photo-2508386.jpeg?auto=compress&cs=tinysrgb&h=130","portrait":"https://images.pexels.com/photos/2508386/pexels-photo-2508386.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800","landscape":"https://images.pexels.com/photos/2508386/pexels-photo-2508386.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"}}';
}
