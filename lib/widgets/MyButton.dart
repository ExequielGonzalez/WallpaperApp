import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final Function onTap;
  final String text;
  final double size = 52;

  MyButton(
      {this.backgroundColor, this.iconColor, this.icon, this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      child: InkResponse(
        onTap: onTap,

//      padding: EdgeInsets.all(10.0),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: text == null
              ? Icon(
                  icon,
                  size: 30.0,
                  color: iconColor,
                )
              : Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
