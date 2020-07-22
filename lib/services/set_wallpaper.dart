import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:wallpaperplugin/wallpaperplugin.dart';
import 'package:flutter/services.dart';

class SetWallpaper {
  static void setWallpaper(String url, int id) async {
    String photoId = id.toString();
    String _localFile;
    print(url);
    if (await _checkAndGetPermission() != null) {
      Dio dio = Dio();
      final Directory appDirectory = await getExternalStorageDirectory();
      final Directory directory =
          await Directory(appDirectory.path + '/wallpapers')
              .create(recursive: true);
      final String dir = directory.path;
      final String localFile = '$dir/$photoId.jpeg';
      final File file = File(localFile);
      if (!file.existsSync()) {
        try {
          await dio.download(
            url, localFile,
            onReceiveProgress: (received, total) {
              if (total != -1) {
                print('Photo downloading: ' +
                    (received / total * 100).toStringAsFixed(0) +
                    "%");
              } //endif
            }, //onReceiveProgress
          ); //dio.download
          _localFile = localFile;
        } on PlatformException catch (error) {
          print(error);
        }
      } else {
        _localFile = localFile;
      }

      try {
//        Wallpaperplugin.setWallpaperWithCrop(localFile: _localFile);
        Wallpaperplugin.setAutoWallpaper(localFile: _localFile);
      } on PlatformException catch (e) {
        print(e);
      }
    }
  }

  static Future<bool> _checkAndGetPermission() async {
    final PermissionStatus permission = await Permission.storage.status;
    if (permission != PermissionStatus.granted) {
      final Map<Permission, PermissionStatus> permissions =
          await [Permission.storage].request();
      if (permissions[Permission.storage] != PermissionStatus.granted) {
        return null;
      }
    }
    return true;
  }
}
