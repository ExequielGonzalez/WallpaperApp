import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallpaper/constants.dart';
import 'package:wallpaper/services/banned_images.dart';
import 'package:wallpaper/services/can_new_photo.dart';
import 'package:wallpaper/services/directory_manager.dart';
import 'package:wallpaper/services/images.dart';
import 'package:wallpaper/services/images_manager.dart';
import 'package:wallpaper/services/web_images.dart' as WebImage;
import 'package:wallpaper/widgets/InfoDialog.dart';
import 'package:wallpaper/widgets/MyButton.dart';
import 'package:wallpaper/services/set_wallpaper.dart';
import 'package:wallpaper/widgets/error_404_widget.dart';
import 'package:wallpaper/widgets/pexel_banner.dart';
import 'package:wallpaper/services/date.dart';
import 'package:wallpaper/widgets/reload_dialog.dart';
import 'package:wallpaper/widgets/share_dialog.dart';
import 'package:network_to_file_image/network_to_file_image.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textEditingController =
      TextEditingController(); //to reach the code enter in the share screen
  PhotosModel photo;

  ImagesManager imagesManager;
  DirectoryManager directoryManager;

  double getHeight() => MediaQuery.of(context).size.height;
  double getWidth() => MediaQuery.of(context).size.width;

  Future<void> updatePhoto({bool force, bool process, String id}) async {
    imagesManager.getPhoto(id: id, process: process);
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        photo = imagesManager.getPhoto(process: false);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    imagesManager = ImagesManager();
    photo = imagesManager.getPhoto();
    directoryManager = DirectoryManager();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //To be safe from notch
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.85,
            child: (photo != null)
                ? Image(
                    fit: BoxFit.cover,
                    image: NetworkToFileImage(
                      url: photo.src.portrait,
                      file:
                          directoryManager.fileFromDocsDir('${photo.id}.jpeg'),
                      debug: true,
                    ),
                  )
                : Error404Widget(
                    restartFunction: () {
                      setState(() {
                        photo = imagesManager.getPhoto();
                      });
                    },
                  ),
//
          ),
          Positioned(
            left: getWidth() / 15,
            right: getWidth() / 15,
            bottom: 16 * getHeight() / 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MyButton(
                  backgroundColor: Colors.white,
                  icon: Icons.refresh,
                  iconColor: Colors.black,
                  onTap: () {
                    CanNewPhoto canNewPhoto = CanNewPhoto();
                    Date date = Date();
                    (date.isNewDay())
                        ? imagesManager.getPhoto()
                        : showDialog(
                            context: context,
                            builder: (context) => ReloadDialog(
                              cantPhotos: canNewPhoto.cantNewPhotos,
                              reloadPhoto: () async {
                                setState(() {
                                  photo = imagesManager.getPhoto(force: true);
                                });
                              },
                            ),
                          );
                  },
                ),
                MyButton(
                  backgroundColor: Colors.white,
                  icon: Icons.share,
                  iconColor: Colors.black,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => ShareDialog(
                        photoId: photo.id,
                        controller: textEditingController,
                      ),
                    );
                    if (textEditingController.text.isNotEmpty) {
                      print(textEditingController.text);

                      //after 1 second, go to /home
                      await updatePhoto(
                          id: textEditingController.text, process: false);
                      textEditingController.clear();
                    }
                  },
                ),
                MyButton(
                  backgroundColor: Colors.white,
                  text: 'SET',
                  onTap: () {
                    SetWallpaper.setWallpaper(photo.src.portrait, photo.id);
                  },
                ),
                MyButton(
                  backgroundColor: Colors.white,
                  iconColor: Colors.black,
                  icon: Icons.info,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => InfoDialog(
                        photographer: photo.photographer,
                        photographerURL: photo.photographerUrl,
                        url: photo.url,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.115,
            right: 0,
            child: PexelBanner(),
          )
        ],
      ),
    );
  }
}
