import 'package:flutter/material.dart';
import 'package:wallpaper/widgets/text_url.dart';

import '../constants.dart';

class InfoDialog extends StatelessWidget {
  final String photographer;
  final String photographerURL;
  final String url;

  InfoDialog({this.photographer, this.photographerURL, this.url});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Information',
                style: kDialogTitleStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Photographer',
                style: kDialogSubTitleStyle,
              ),
              Text(
                '$photographer',
                style: kDialogContentStyle,
              ),
              Text(
                'Photographer url',
                style: kDialogSubTitleStyle,
              ),
              TextUrl(url: photographerURL),
              Text(
                'More info',
                style: kDialogSubTitleStyle,
              ),
              TextUrl(url: url),
            ],
          ),
        ),
      ),
    );
  }
}
