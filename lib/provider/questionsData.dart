import 'package:flutter/material.dart';
import 'package:review/model/questionsModel.dart';

class QuestionsProvider extends ChangeNotifier {
  List<QuestionModel> questions=[];
  int idQuestion=0;

  int get getIdQuestion =>idQuestion;

  updatedIdQuestion(int idQuestion){
    this.idQuestion = idQuestion;
    notifyListeners();
  }
  updateQuestions(List<QuestionModel> questions) {
    this.questions = questions;
    notifyListeners();
  }
  addQuestions(data) {
    this.questions.add(data);
    notifyListeners();
  }
}
