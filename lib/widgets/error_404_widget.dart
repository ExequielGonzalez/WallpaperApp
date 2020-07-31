import 'package:flutter/material.dart';

import '../constants.dart';

class Error404Widget extends StatelessWidget {
  final Function restartFunction;
  final int delay;

  Error404Widget({this.restartFunction, this.delay = 1}) {
    Future.delayed(Duration(seconds: delay), () {
      //after 'delay' second,the home page is recharged
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
