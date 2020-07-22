import 'package:flutter/material.dart';
import 'package:wallpaper/services/launch_url.dart';

import '../constants.dart';

class TextUrl extends StatelessWidget {
  final String url;
  final String text;
  final bool isUrl;

  TextUrl({@required this.url, this.text, this.isUrl = true});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          LaunchUrl.launchInBrowser(url);
        },
        child: Text(
          text == null ? url : text,
          style: isUrl ? kTextUrl : kTextPexel,
        ),
      ),
    );
  }
}
