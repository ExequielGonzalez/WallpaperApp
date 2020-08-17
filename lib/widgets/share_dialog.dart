import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../constants.dart';

class ShareDialog extends StatelessWidget {
  final int photoId;
  TextEditingController controller;
  String enterId;
  ShareDialog({this.photoId, this.controller});

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
        height: MediaQuery.of(context).size.height / 2,
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
                  'Share',
                  style: kDialogTitleStyle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Enter code to get a new photo',
                style: kDialogSubTitleStyle.copyWith(fontSize: 20),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Form(
                      child: TextFormField(
                        controller: controller,
//                        onChanged: (text) {
//                          enterId = text;
//                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        maxLength: 8,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Write code here',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(12)),
                          ),
                          fillColor: Colors.white10,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                      print(controller.text);
                    },
                    color: Colors.grey,
                    splashColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Text(
                      'Get it!',
                      style: kDialogSubTitleStyle.copyWith(
                          color: Colors.black, letterSpacing: 0.7),
                    ),
                  ),
                ],
              ),
              Text(
                'Share your wallpaper',
                style: kDialogSubTitleStyle.copyWith(fontSize: 20),
              ),
              Container(
                child: RaisedButton(
                  color: Colors.grey,
                  splashColor: Colors.green,
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Text(
                    'Share it!',
                    style: kDialogSubTitleStyle.copyWith(color: Colors.black),
                  ),
                  onPressed: () {
                    Share.share(kTextShare + '\n Code: $photoId');
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
