import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallpaper/services/images.dart';
import 'package:wallpaper/services/web_images.dart' as WebImage;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PhotosModel photo;

  void getPhoto() async {
    photo = await WebImage.getTrendingWallpaper();
  }

  @override
  void initState() {
    photo.url =
        'https://images.unsplash.com/photo-1532264523420-881a47db012d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9';
    getPhoto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        progressIndicatorBuilder: (context, url, progress) =>
            CircularProgressIndicator(
          value: progress.progress,
        ),
        imageUrl: photo.url,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
