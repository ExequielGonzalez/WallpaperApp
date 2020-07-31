import 'package:http/http.dart' as http;
import 'package:wallpaper/constants.dart';
import 'package:wallpaper/services/banned_images.dart';
import 'dart:convert';
import 'package:wallpaper/services/images.dart';
import 'dart:math';

String kAPI = '563492ad6f917000010000017070ee497ec64313a7552a5527b4c75f ';

Future<PhotosModel> getTrendingWallpaper() async {
  PhotosModel photo;
  await http.get("https://api.pexels.com/v1/curated?per_page=1&page=1",
      headers: {"Authorization": kAPI}).then((value) {
    print(value.statusCode);
    print(value.body);
    if (value.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
//      return PhotosModel.fromMap(element);
        photo = PhotosModel.fromJson(element);
      });
    } else
      throw Exception(
          'Unable to get an image from the server. Check your internet connection');
  });
  return photo;
}

Future<Map<String, dynamic>> getSpecificWallpaperByPage(
    {String topic, String page}) async {
  Map<String, dynamic> photoAsString;
  PhotosModel photo;
  if (page == null) page = getRandomNumber(kTotalPhotos).toString();
  await http.get(
      "https://api.pexels.com/v1/search?query=$topic&per_page=1&page=$page",
      headers: {"Authorization": kAPI}).then((value) {
    print(value.statusCode);
    print(value.body);

    if (value.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      print(jsonData['total_results']);
      jsonData["photos"].forEach((element) {
//        print('esto guardaria');

        photoAsString = element;
//        print(element);
//        return element;
//      return PhotosModel.fromMap(element);
//        photo = PhotosModel.fromMap(element);
      });
    } else
      throw Exception(
          'Unable to get an image from the server. Check your internet connection');
  });
//  return photo;
  return photoAsString;
}

Future<Map<String, dynamic>> getSpecificWallpaperById({String id}) async {
  PhotosModel photo;
  Map<String, dynamic> photoAsString;
  await http.get("https://api.pexels.com/v1/photos/$id",
      headers: {"Authorization": kAPI}).then((value) {
    print(value.statusCode);
    print(value.body);

    if (value.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      photoAsString = jsonData;
    } else
      throw Exception(
          'Unable to get an image from the server. Check your internet connection');
  });
  return photoAsString;
}

int getRandomNumber(int range) {
  BannedImages bannedImages = BannedImages();
  int newImage = Random().nextInt(range) + 1;
  if (bannedImages.isBanned(newImage)) {
    newImage = getRandomNumber(range);
  }
  bannedImages.banImage(newImage);
  return newImage;
}
