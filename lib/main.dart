import 'package:flutter/material.dart';
import 'package:wallpaper/screens/home.dart';
import 'package:wallpaper/screens/starting.dart';

void main() => runApp(Wallpaper());

class Wallpaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper',
      initialRoute: '/',
      routes: {
        '/home': (context) => Home(),
        '/': (context) => Starting(),
      },
    );
  }
}
