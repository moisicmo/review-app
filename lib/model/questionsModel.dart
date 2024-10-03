// To parse this JSON data, do
//
//     final QuestionModel = QuestionModelFromJson(jsonString);

import 'dart:convert';

QuestionModel questionModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
    QuestionModel({
        this.id,
        this.idQuestion,
        this.idTypeAnswer,
        this.idSurvey,
        this.qstQuestion,
        this.qstState,
    });

    int? id;
    int? idQuestion;
    int? idTypeAnswer;
    int? idSurvey;
    String? qstQuestion;
    int? qstState;

    factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        idQuestion: json["idQuestion"],
        idTypeAnswer: json["idTypeAnswer"],
        idSurvey: json["idSurvey"],
        qstQuestion: json["qstQuestion"],
        qstState: json["qstState"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idQuestion": idQuestion,
        "idTypeAnswer": idTypeAnswer,
        "idSurvey": idSurvey,
        "qstQuestion": qstQuestion,
        "qstState": qstState,
    };
}
