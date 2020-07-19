import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallpaper/constants.dart';
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
    photo = WebImage.getSpecificWallpaper(kTopic);
  }

  double getHeight() => MediaQuery.of(context).size.height;
  double getWidth() => MediaQuery.of(context).size.width;

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
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
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
                    imageUrl: snapshot.data.src.large,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  );
                } else if (snapshot.hasError) {
                  print('${snapshot.error}');
                  return Text('${snapshot.error}');
                } else
                  return CircularProgressIndicator();
              }),
        ),
        Positioned(
          left: getWidth() / 10,
          right: getWidth() / 10,
          bottom: 15 * getHeight() / 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MyButton(
                backgroundColor: Colors.white,
                icon: Icons.settings,
                iconColor: Colors.black,
              ),
              MyButton(
                backgroundColor: Colors.blue.shade200,
                iconColor: Colors.black,
                icon: Icons.save_alt,
              ),
              MyButton(
                backgroundColor: Colors.white,
                iconColor: Colors.black,
                icon: Icons.info,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class MyButton extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final Function onTap;
  MyButton({this.backgroundColor, this.iconColor, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onTap,
      elevation: 2.0,
      fillColor: backgroundColor,
      child: Icon(
        icon,
        size: 25.0,
        color: iconColor,
      ),
      padding: EdgeInsets.all(10.0),
      shape: CircleBorder(),
    );
  }
}
