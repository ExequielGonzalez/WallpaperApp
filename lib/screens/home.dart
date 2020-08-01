import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallpaper/constants.dart';
import 'package:wallpaper/services/banned_images.dart';
import 'package:wallpaper/services/can_new_photo.dart';
import 'package:wallpaper/services/images.dart';
import 'package:wallpaper/services/shared_preferences.dart';
import 'package:wallpaper/services/web_images.dart' as WebImage;
import 'package:wallpaper/widgets/InfoDialog.dart';
import 'package:wallpaper/widgets/MyButton.dart';
import 'package:wallpaper/services/set_wallpaper.dart';
import 'package:wallpaper/widgets/error_404_widget.dart';
import 'package:wallpaper/widgets/pexel_banner.dart';
import 'package:wallpaper/services/date.dart';
import 'package:wallpaper/widgets/reload_dialog.dart';
import 'package:wallpaper/widgets/share_dialog.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textEditingController =
      TextEditingController(); //to reach the code enter in the share screen

  Future<PhotosModel> photo;

  String lastImage;
  int photoWidth;
  int photoHeight;
  String photographer;
  String photographerURL;
  String photoUrl;
  String urlToDownload;
  int photoId;

  void getPhoto({bool force = false}) async {
//    photo = WebImage.getTrendingWallpaper();
    Date date = Date();
    if (date.isNewDay()) {
      print('aca entro bro');
      setState(() {
        photo = WebImage.getSpecificWallpaper(topic: kTopic);
      });
    } else {
      CanNewPhoto canNewPhoto = CanNewPhoto();
      if (canNewPhoto.canGetNewPhoto() && force) {
        print(
            'This is not a new day, but also you can already get ${canNewPhoto.cantNewPhotos} awesome wallpapers...');
        canNewPhoto.reduceCantPhotos();
        setState(() {
          photo = WebImage.getSpecificWallpaper(topic: kTopic);
        });
      } else {
        BannedImages bannedImages = BannedImages();
        print('this is not a new day...');
        setState(() {
          lastImage = bannedImages.lastBanned();
          print('the last image is: $lastImage');
          (photo == null)
              ? photo =
                  WebImage.getSpecificWallpaper(topic: kTopic, page: lastImage)
              : null; //the idea is do nothing if a wallpaper is already loaded.
        });
      }
    }
  }

  double getHeight() => MediaQuery.of(context).size.height;
  double getWidth() => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();

    getPhoto();
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
            child: FutureBuilder(
                future: photo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    photoWidth = snapshot.data.width;
                    photoHeight = snapshot.data.height;
                    photographer = snapshot.data.photographer;
                    photographerURL = snapshot.data.photographerUrl;
                    photoUrl = snapshot.data.url;
                    urlToDownload = snapshot.data.src.portrait; //800x1200
                    photoId = snapshot.data.id;
                    return CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) =>
                          CircularProgressIndicator(
                        value: progress.progress,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageUrl: snapshot.data.src.portrait,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    );
                  } else if (snapshot.hasError) {
                    print('${snapshot.error}');
                    return Error404Widget(
                        delay: 1,
                        restartFunction: () {
                          BannedImages bannedImages = BannedImages();
                          setState(() {
                            photo = WebImage.getSpecificWallpaper(
                                topic: kTopic, page: bannedImages.lastBanned());
                          });
                        });
                  } else
                    return CircularProgressIndicator();
                }),
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
                        ? getPhoto()
                        : showDialog(
                            context: context,
                            builder: (context) => ReloadDialog(
                              cantPhotos: canNewPhoto.cantNewPhotos,
                              reloadPhoto: () async {
                                setState(() {
                                  getPhoto(force: true);
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
                          photoId: photoId,
                          controller: textEditingController,
                        ),
                      );
                      if (textEditingController.text.isNotEmpty) {
                        print(textEditingController.text);

                        setState(() {
                          photo = WebImage.getSpecificWallpaperById(
                              id: textEditingController.text);
                        });
                        textEditingController.clear();
                      }
                    }),
                MyButton(
                  backgroundColor: Colors.white,
                  text: 'SET',
                  onTap: () {
                    SetWallpaper.setWallpaper(urlToDownload, photoId);
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
                        photographer: photographer,
                        photographerURL: photographerURL,
                        url: photoUrl,
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
