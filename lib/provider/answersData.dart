import 'package:flutter/material.dart';
import 'package:review/model/answersModel.dart';

class AnswersProvider extends ChangeNotifier {
  List<AnswerModel> answers=[];

  // List get getAnswers => answers;

  updateAnswers(List<AnswerModel> answers) {
    this.answers = answers;
    notifyListeners();
  }
  addAnswers(data) {
    this.answers.add(data);
    notifyListeners();
  }
}
