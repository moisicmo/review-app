import 'dart:math';

import 'package:flutter/material.dart';

class IconRoundedComponent extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final double angle;
  final Color? colorIcon;
  const IconRoundedComponent(
      {Key? key,
      required this.onTap,
      required this.icon,
      this.angle = 90 * pi / 1,
      this.colorIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
      onTap: onTap,
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Transform.rotate(
            angle: angle,
            child: Icon(
              icon,
              color: colorIcon,
            ),
          ),
        ),
      ),
    ));
  }
}
