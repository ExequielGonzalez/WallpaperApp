import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wallpaper/widgets/text_url.dart';

class PexelBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              child: TextUrl(
                url: 'https://www.pexels.com',
                text: "Photos provided by Pexels",
                isUrl: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
