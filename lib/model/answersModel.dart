// To parse this JSON data, do
//
//     final answerModel = answerModelFromJson(jsonString);

import 'dart:convert';

AnswerModel answerModelFromJson(String str) => AnswerModel.fromJson(json.decode(str));

String answerModelToJson(AnswerModel data) => json.encode(data.toJson());

class AnswerModel {
    AnswerModel({
        this.id,
        this.idQuestion,
        this.idSurvey,
        this.idTypeAnswer,
        this.answer,
        this.date,
    });

    int? id;
    int? idQuestion;
    int? idSurvey;
    int? idTypeAnswer;
    String? answer;
    String? date;

    factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        id: json["id"],
        idQuestion: json["idQuestion"],
        idSurvey: json["idSurvey"],
        idTypeAnswer: json["idTypeAnswer"],
        answer: json["answer"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idQuestion": idQuestion,
        "idSurvey": idSurvey,
        "idTypeAnswer": idTypeAnswer,
        "answer": answer,
        "date":date
    };
}
