import 'package:flutter/material.dart';
import 'package:review/model/surveysModel.dart';

class SurveysProvider extends ChangeNotifier {
  List<SurveyModel> surveys=[];

  // List get getAnswers => surveys;

  updateSurveys(List<SurveyModel> surveys) {
    this.surveys = surveys;
    notifyListeners();
  }
  addSurveys(data) {
    this.surveys.add(data);
    notifyListeners();
  }
}
