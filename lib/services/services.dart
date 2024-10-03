




const String url = 'https://reviewserver.online';

// const String url = 'http://172.16.3.252:3000';
String serviceAuthSession()=>'$url/api/admin/auth';

String serviceGetAreaSurveys( String idCampus) => '$url/api/areas/surveys/campus/$idCampus';

String serviceRegisterTerminalSurvey() => '$url/api/terminal/register/survey/terminal';

String serviceGetQuestionsSurvey( String idSurvey ) => '$url/api/survey/questions/$idSurvey';