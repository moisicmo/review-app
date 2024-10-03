import 'package:flutter/material.dart';
import 'package:review/src/screens/typeAnswers/five_face.dart';
import 'package:review/src/screens/typeAnswers/four_face.dart';
import 'package:review/src/screens/typeAnswers/one_one_hundred.dart';
import 'package:review/src/screens/typeAnswers/one_ten.dart';
import 'package:review/src/screens/typeAnswers/three_faces.dart';
import 'package:review/src/screens/typeAnswers/yes_not.dart';

class TabQuestion extends StatefulWidget {
  final String question;
  final int idTypeAnswer;
  const TabQuestion(
      {Key? key, required this.question, required this.idTypeAnswer})
      : super(key: key);

  @override
  State<TabQuestion> createState() => _TabQuestionState();
}

class _TabQuestionState extends State<TabQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.question),
          if (widget.idTypeAnswer == 1)
            Expanded(
                child: FiveFace(buttonState: true, nextQuestion: (data) {})),
          if (widget.idTypeAnswer == 2)
            Expanded(
                child: FourFace(buttonState: true, nextQuestion: (data) {})),
          if (widget.idTypeAnswer == 3)
            Expanded(
                child: ThreeFace(buttonState: true, nextQuestion: (data) {})),
          if (widget.idTypeAnswer == 4)
            Expanded(
                child: YesOrNot(buttonState: true, nextQuestion: (data) {})),
          if (widget.idTypeAnswer == 5)
            const Expanded(child: Text('COMENTARIO')),
          if (widget.idTypeAnswer == 6)
            Expanded(
                child: OneToOneHundred(
                    buttonState: true,
                    nextQuestion: (data) {},
                    onChangedAnswer: () {})),
          if (widget.idTypeAnswer == 7)
            Expanded(
                child: OneToTen(
                    buttonState: true,
                    nextQuestion: (data) {},
                    onChangedAnswer: () {})),
        ],
      ),
    ));
  }
}
