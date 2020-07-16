import 'package:flutter/material.dart';
import 'package:wallpaper/screens/home.dart';

void main() => runApp(Wallpaper());

class Wallpaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper',
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
      },
    );
  }
}
