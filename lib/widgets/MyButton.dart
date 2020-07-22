import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final Function onTap;
  final String text;
  MyButton(
      {this.backgroundColor, this.iconColor, this.icon, this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onTap,
      elevation: 2.0,
      fillColor: backgroundColor,
      child: text == null
          ? Icon(
              icon,
              size: 25.0,
              color: iconColor,
            )
          : Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
      padding: EdgeInsets.all(10.0),
      shape: CircleBorder(),
    );
  }
}
