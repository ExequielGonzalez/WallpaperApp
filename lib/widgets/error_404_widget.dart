import 'package:flutter/material.dart';

import '../constants.dart';

class Error404Widget extends StatelessWidget {
  final Function restartFunction;

  Error404Widget({this.restartFunction}) {
    Future.delayed(const Duration(seconds: 1), () {
      //after 1 second,the home page is recharged
      restartFunction();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kBackgroundGradient,
        child: Center(
          child: Text(
            'Something went wrong.\n\nRecharging your last image...',
            style: kDialogTitleStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
