// To parse this JSON data, do
//
//     final surveyModel = surveyModelFromJson(jsonString);

import 'dart:convert';

SurveyModel surveyModelFromJson(String str) => SurveyModel.fromJson(json.decode(str));

String surveyModelToJson(SurveyModel data) => json.encode(data.toJson());

class SurveyModel {
    SurveyModel({
        this.id,
        this.idAdministrator,
        this.idSurvey,
        this.idAreaCampus,
        this.srvName,
        this.srvState,
    });

    int? id;
    int? idAdministrator;
    int? idSurvey;
    int? idAreaCampus;
    String? srvName;
    int? srvState;

    factory SurveyModel.fromJson(Map<String, dynamic> json) => SurveyModel(
        id: json["id"],
        idAdministrator: json["idAdministrator"],
        idSurvey: json["idSurvey"],
        idAreaCampus: json["idAreaCampus"],
        srvName: json["srvName"],
        srvState: json["srvState"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idAdministrator": idAdministrator,
        "idSurvey": idSurvey,
        "idAreaCampus": idAreaCampus,
        "srvName": srvName,
        "srvState": srvState,
    };
}