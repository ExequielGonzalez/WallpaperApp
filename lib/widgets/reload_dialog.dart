import 'package:flutter/material.dart';
import 'package:wallpaper/services/can_new_photo.dart';

import '../constants.dart';

class ReloadDialog extends StatelessWidget {
  final int cantPhotos;
  final Function reloadPhoto;
  final Function watchAd;
  ReloadDialog({this.cantPhotos, this.reloadPhoto, this.watchAd});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'New wallpaper',
                  style: kDialogTitleStyle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                (cantPhotos > 0)
                    ? 'You can get $cantPhotos new photos yet!'
                    : "You can't get a new photo until tomorrow, or you can watch a little ad to get a new one!",
                style: kDialogSubTitleStyle.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Container(
                child: (cantPhotos > 0)
                    ? RaisedButton(
                        color: Colors.grey,
                        splashColor: Colors.green,
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Text(
                          'Get a new one!',
                          style: kDialogSubTitleStyle.copyWith(
                              color: Colors.black),
                        ),
                        onPressed: () {
                          reloadPhoto();
                          Navigator.pop(context);
                        },
                      )
                    : RaisedButton(
                        color: Colors.grey,
                        splashColor: Colors.green,
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Text(
                          'Watch an Ad!',
                          style: kDialogSubTitleStyle.copyWith(
                              color: Colors.black),
                        ),
                        onPressed: () {
                          watchAd();
                          Navigator.pop(context);
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
