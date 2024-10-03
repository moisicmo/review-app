import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:review/main.dart';
import 'package:review/provider/db_provider.dart';
import 'package:review/provider/questionsData.dart';
import 'package:review/provider/surveysData.dart';
import 'package:review/services/auth_service.dart';
import 'package:review/services/service_method.dart';
import 'package:review/services/services.dart';

Future<bool>update(context) async {
  final questionsProvider =
      Provider.of<QuestionsProvider>(context, listen: false);
  final surveysProvider = Provider.of<SurveysProvider>(context, listen: false);
  final authService = Provider.of<AuthService>(context, listen: false);

  var response = await serviceMethod(true, context, 'get', null,
      serviceGetQuestionsSurvey(prefs!.getString('idSurvey')!), true,false);
  if (response != null) {
    await DBProvider.db.deleteALLQuestionsAndSurvey();
    await questionsProvider.updateQuestions([]);
    await questionsProvider.updatedIdQuestion(0);
    debugPrint('todo bien');
    debugPrint('${response.body}');
    Map<String, dynamic> parsedJson = json.decode(response.body);
    debugPrint(parsedJson['ars_name'].toString());
    debugPrint(parsedJson['questions'].length.toString());
    var idSurvey = await DBProvider.db.newSurveyModel(SurveyModel(
      idAdministrator: parsedJson['id_administrator'],
      idSurvey: parsedJson['id'],
      idAreaCampus: parsedJson['id_campus'],
      srvName: parsedJson['srv_name'],
      srvState: parsedJson['srv_state'],
    ));
    await DBProvider.db
        .getSurveyModelById(idSurvey)
        .then((result) => surveysProvider.addSurveys(result));
    for (var item in parsedJson['questions']) {
      debugPrint(item['qst_question'].toString());
      var idQuestion = await DBProvider.db.newQuestionModel(QuestionModel(
          idQuestion: item['id'],
          idTypeAnswer: item['id_type_answer'],
          idSurvey: parsedJson['id'],
          qstQuestion: item['qst_question'],
          qstState: item['qst_state']));
      await DBProvider.db
          .getQuestionModelById(idQuestion)
          .then((result) => questionsProvider.addQuestions(result));
    }
    prefs!.setString('stateApp', 'questions');

    await authService.registerQuestions();
    return true;
  }
  return true;
}
