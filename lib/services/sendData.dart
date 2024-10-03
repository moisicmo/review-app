import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:review/provider/answersData.dart';
import 'package:review/provider/db_provider.dart';

sendData(context) async {
  if (await InternetConnectionChecker().connectionStatus ==
      InternetConnectionStatus.disconnected) {
    return;
  }
  int count = 0;
  List answers = await DBProvider.db.getALLAnswers();
  debugPrint(answers.length.toString());
  for (var item in answers) {
    debugPrint('ciclo: $count');
    debugPrint('idQuestion: ${item.idQuestion}');
    debugPrint('idSurvey: ${item.idSurvey}');
    debugPrint('idTypeAnswer: ${item.idTypeAnswer}');
    debugPrint('answer: ${item.answer}');
    var body = jsonEncode({
      "id_question": item.idQuestion,
      "id_survey": item.idSurvey,
      "id_type_answer": item.idTypeAnswer,
      "answer": item.answer,
      "date_answer": item.date
    });
    debugPrint(body);
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    var url = Uri.parse('https://reviewserver.online/api/answer/register');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    debugPrint('object');
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    switch (response.statusCode.toString()) {
      case '200':
        final answersProvider =
            Provider.of<AnswersProvider>(context, listen: false);
        await DBProvider.db.deleteAnswerById(item.id);
        answersProvider.updateAnswers(await DBProvider.db.getALLAnswers());
        count++;
        break;
      default:
        return null;
    }
  }
  if (answers.length < count) {
    debugPrint('se regitro todos las respuestas en el servidor');
    await DBProvider.db.deleteALLAnswers();
  }
}
