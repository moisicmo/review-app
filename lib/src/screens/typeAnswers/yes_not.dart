import 'dart:async';

import 'package:flutter/material.dart';
import 'package:review/src/screens/surveys/icons.dart';

class YesOrNot extends StatefulWidget {
  final Function(String) nextQuestion;
  final bool buttonState;
  const YesOrNot(
      {Key? key, required this.nextQuestion, required this.buttonState})
      : super(key: key);

  @override
  State<YesOrNot> createState() => _YesOrNotState();
}

class _YesOrNotState extends State<YesOrNot> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconsAnimated(
          imageIcon: "assets/icons/si.png",
          onTap: () =>
              widget.buttonState ? nextQuiestionOnPressed('si', 1) : null,
        ),
        IconsAnimated(
          imageIcon: "assets/icons/no.png",
          onTap: () =>
              widget.buttonState ? nextQuiestionOnPressed('no', 1) : null,
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
