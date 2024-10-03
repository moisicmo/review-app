import 'dart:async';

import 'package:flutter/material.dart';
import 'package:review/src/screens/surveys/icons.dart';

class FourFace extends StatefulWidget {
  final Function(String) nextQuestion;
  final bool buttonState;
  const FourFace(
      {Key? key, required this.nextQuestion, required this.buttonState})
      : super(key: key);

  @override
  State<FourFace> createState() => _FourFaceState();
}

class _FourFaceState extends State<FourFace> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconsAnimated(
          imageIcon: "assets/icons/1.png",
          onTap: () =>
              widget.buttonState ? nextQuiestionOnPressed('muy bien', 1) : null,
        ),
        IconsAnimated(
          imageIcon: "assets/icons/2.png",
          onTap: () =>
              widget.buttonState ? nextQuiestionOnPressed('bien', 1) : null,
        ),
        IconsAnimated(
          imageIcon: "assets/icons/3.png",
          onTap: () => widget.buttonState
              ? nextQuiestionOnPressed('masomenos', 1)
              : null,
        ),
        IconsAnimated(
          imageIcon: "assets/icons/5.png",
          onTap: () =>
              widget.buttonState ? nextQuiestionOnPressed('mal', 1) : null,
        ),
      ],
    );
  }

  nextQuiestionOnPressed(String text, int value) {
    setState(() => count = count + value);
    Timer(const Duration(milliseconds: 50), () async {
      if (count == 1) {
        widget.nextQuestion(text);
      }
      setState(() => count = 0);
    });
  }
}
