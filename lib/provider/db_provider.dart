
import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import 'package:review/model/answersModel.dart';
import 'package:review/model/questionsModel.dart';
import 'package:review/model/surveysModel.dart';
export 'package:review/model/answersModel.dart';
export 'package:review/model/surveysModel.dart';
export 'package:review/model/questionsModel.dart';

class DBProvider{

  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();


  Future<Database> get database async {
    if(_database!=null) return _database!;


    _database = await initDB();
    return _database!;

  }
  Future<Database> initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // final path = join(documentsDirectory.path, 'service_qualifier.db');
    final path = join(documentsDirectory.path, 'review.db');
    return await openDatabase(
      path,
      version:5,
      onOpen: (db){ },
      onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE serv_questions(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              idQuestion INTEGER,
              idTypeAnswer INTEGER,
              idSurvey INTEGER,
              qstQuestion TEXT,
              qstState INTEGER
            )
          ''');
          await db.execute('''
            CREATE TABLE serv_survey(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              idAdministrator INTEGER,
              idSurvey INTEGER,
              idAreaCampus INTEGER,
              srvName TEXT,
              srvDescription TEXT,
              srvState INTEGER
            )
          ''');
          await db.execute('''
            CREATE TABLE serv_answers(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              idQuestion INTEGER,
              idSurvey INTEGER,
              idTypeAnswer INTEGER,
              answer TEXT,
              date TEXT
            )
          ''');
      }
    );
  }
  //SAVE INFO
  Future<int> newQuestionModel( QuestionModel data )async{
    final db = await database;
    final res = await db.insert('serv_questions',data.toJson());
    return res;
  }
  Future<int> newSurveyModel( SurveyModel data )async{
    final db = await database;
    final res = await db.insert('serv_survey',data.toJson());
    return res;
  }
  Future<int> newAnswerModel( AnswerModel data )async{
    final db = await database;
    final res = await db.insert('serv_answers',data.toJson());
    return res;
  }
  //GET INFO TO ID
  Future<QuestionModel> getQuestionModelById(int id) async{
    final db = await database;
    final res = await db.query('serv_questions', where: 'id = ?', whereArgs: [id]);
    
    return QuestionModel.fromJson( res.first);
  }
  Future<SurveyModel> getSurveyModelById(int id) async{
    final db = await database;
    final res = await db.query('serv_survey', where: 'id = ?', whereArgs: [id]);
    
    return SurveyModel.fromJson( res.first);
  }
  Future<AnswerModel> getAnswerModelById(int id) async{
    final db = await database;
    final res = await db.query('serv_answers', where: 'id = ?', whereArgs: [id]);
    
    return AnswerModel.fromJson( res.first);
  }
  //OBTENER TODOS LOS DATOS
  Future<List<QuestionModel>> getALLQuestions() async{
    final db = await database;
    final res = await db.query('serv_questions');
    return res.isNotEmpty
          ? res.map((c)=>QuestionModel.fromJson(c)).toList()
          :[];
  }
  Future<List<AnswerModel>> getALLAnswers() async{
    final db = await database;
    final res = await db.query('serv_answers');
    return res.isNotEmpty
          ? res.map((c)=>AnswerModel.fromJson(c)).toList()
          :[];
  }
  //ELIMINAR TODOS LOS REGISTROS DE ENCUESTAS Y PREGUNTAS
    Future<int> deleteALLQuestionsAndSurvey()async{
    final db = await database;
    await db.rawDelete('''
        DELETE FROM serv_questions
    ''');
    await db.rawDelete('''
        DELETE FROM serv_survey
    ''');
    return 1;
  }
  //ELIMINAR TODOS LOS REGISTROS DE ENCUESTAS Y PREGUNTAS
    Future<int> deleteALLAnswers()async{
    final db = await database;
    await db.rawDelete('''
        DELETE FROM serv_answers
    ''');
    return 1;
  }
  //   Future<int> deleteAnswer( int id )async{
  //   final db = await database;
  //   await db.rawDelete('''
  //       DELETE FROM serv_answers where
  //   ''');
  //   return 1;
  // }
  Future<int> deleteAnswerById(int id)async{
    final db = await database;
    final res = await db.delete('serv_answers',where: 'id = ?',whereArgs: [id]);
    return res;
  }
}