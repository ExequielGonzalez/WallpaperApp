import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallpaper/services/images.dart';
import 'package:wallpaper/services/web_images.dart' as WebImage;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<PhotosModel> photo;

  void getPhoto() async {
//    photo = WebImage.getTrendingWallpaper();
    photo = WebImage.getSpecificWallpaper('tiger');
  }

  @override
  void initState() {
    super.initState();
//    photo = PhotosModel();
//    photo.url =
//        'https://images.unsplash.com/photo-1532264523420-881a47db012d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9';
    getPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: photo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) =>
                    CircularProgressIndicator(
                  value: progress.progress,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageUrl: snapshot.data.src.original,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              );
            } else if (snapshot.hasError) {
              print('${snapshot.error}');
              return Text('${snapshot.error}');
            } else
              return CircularProgressIndicator();
          }),
    );
  }
}
