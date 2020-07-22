import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final Function onTap;
  MyButton({this.backgroundColor, this.iconColor, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onTap,
      elevation: 2.0,
      fillColor: backgroundColor,
      child: Icon(
        icon,
        size: 25.0,
        color: iconColor,
      ),
      padding: EdgeInsets.all(10.0),
      shape: CircleBorder(),
    );
  }
}
