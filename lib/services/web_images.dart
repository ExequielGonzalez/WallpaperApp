import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wallpaper/services/images.dart';

String kAPI = '563492ad6f917000010000017070ee497ec64313a7552a5527b4c75f ';

Future<PhotosModel> getTrendingWallpaper() async {
  PhotosModel photo;
  await http.get("https://api.pexels.com/v1/curated?per_page=1&page=1",
      headers: {"Authorization": kAPI}).then((value) {
    print(value.body);

    Map<String, dynamic> jsonData = jsonDecode(value.body);
    jsonData["photos"].forEach((element) {
      //print(element);
//      return PhotosModel.fromMap(element);
      photo = PhotosModel.fromMap(element);
    });
  });
  return photo;
}
