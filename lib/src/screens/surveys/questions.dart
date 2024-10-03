import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:review/provider/answersData.dart';
import 'package:review/provider/db_provider.dart';
import 'package:review/provider/questionsData.dart';
import 'package:review/src/screens/typeAnswers/coment.dart';
import 'package:review/src/screens/typeAnswers/five_face.dart';
import 'package:review/src/screens/typeAnswers/four_face.dart';
import 'package:review/src/screens/typeAnswers/one_one_hundred.dart';
import 'package:review/src/screens/typeAnswers/one_ten.dart';
import 'package:review/src/screens/typeAnswers/three_faces.dart';
import 'package:review/src/screens/typeAnswers/yes_not.dart';
import 'package:review/src/screens/login.dart';

import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class PageQuestions extends StatefulWidget {
  const PageQuestions({Key? key}) : super(key: key);

  @override
  State<PageQuestions> createState() => _PageQuestionsState();
}

class _PageQuestionsState extends State<PageQuestions> {
  final CountdownController _controller = CountdownController(autoStart: false);
  TextEditingController coment = TextEditingController();
  int countButton = 0;
  bool stateFinish = false;
  bool buttonState = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final questionsProvider = Provider.of<QuestionsProvider>(context);
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: GestureDetector(
          child: Scaffold(
            body: Center(
              child: !stateFinish
                  ? Column(
                      children: [
                        Countdown(
                          controller: _controller,
                          seconds: 10,
                          build: (_, double time) => Container(),
                          interval: const Duration(milliseconds: 100),
                          onFinished: () {
                            if (questionsProvider.getIdQuestion > 0) {
                              finishQuestion();
                            }
                          },
                        ),
                        if (questionsProvider
                                .questions[questionsProvider.getIdQuestion]
                                .idTypeAnswer ==
                            5)
                          const Spacer(),
                        if (questionsProvider
                                .questions[questionsProvider.getIdQuestion]
                                .idTypeAnswer ==
                            5)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 50.0),
                                width: 200,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: MaterialButton(
                                  splashColor: Colors.transparent,
                                  minWidth: size.width * 0.65,
                                  height: 40,
                                  color: const Color(0xffF26522),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text('  Finalizar ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17)),
                                      ]),
                                  onPressed: () => nextQuestion(coment.text),
                                ),
                              ),
                            ],
                          ),
                        const Spacer(),
                        Text(
                            questionsProvider
                                .questions[questionsProvider.getIdQuestion]
                                .qstQuestion
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 60, fontWeight: FontWeight.bold)),
                        SizedBox(height: size.height * 0.03),
                        if (questionsProvider
                                .questions[questionsProvider.getIdQuestion]
                                .idTypeAnswer ==
                            1)
                          FiveFace(
                              buttonState: buttonState,
                              nextQuestion: (data) => nextQuestion(data)),
                        if (questionsProvider
                                .questions[questionsProvider.getIdQuestion]
                                .idTypeAnswer ==
                            2)
                          FourFace(
                              buttonState: buttonState,
                              nextQuestion: (data) => nextQuestion(data)),
                        if (questionsProvider
                                .questions[questionsProvider.getIdQuestion]
                                .idTypeAnswer ==
                            3)
                          ThreeFace(
                              buttonState: buttonState,
                              nextQuestion: (data) => nextQuestion(data)),
                        if (questionsProvider
                                .questions[questionsProvider.getIdQuestion]
                                .idTypeAnswer ==
                            4)
                          YesOrNot(
                              buttonState: buttonState,
                              nextQuestion: (data) => nextQuestion(data)),
                        if (questionsProvider
                                .questions[questionsProvider.getIdQuestion]
                                .idTypeAnswer ==
                            5)
                          Coment(
                              onChangedAnswer: () => _controller.restart(),
                              coment: coment,
                              nextQuestion: (data) => nextQuestion(data)),
                        if (questionsProvider
                                .questions[questionsProvider.getIdQuestion]
                                .idTypeAnswer ==
                            6)
                          OneToOneHundred(
                              buttonState: buttonState,
                              onChangedAnswer: () => _controller.restart(),
                              nextQuestion: (data) => nextQuestion(data)),
                        if (questionsProvider
                                .questions[questionsProvider.getIdQuestion]
                                .idTypeAnswer ==
                            7)
                          OneToTen(
                              buttonState: buttonState,
                              onChangedAnswer: () => _controller.restart(),
                              nextQuestion: (data) => nextQuestion(data)),
                        const Spacer(),
                      ],
                    )
                  : const Text('MUCHAS GRACIAS',
                      style: TextStyle(fontSize: 30)),
            ),
          ),
          onLongPressMoveUpdate: (w) {
            debugPrint('$countButton');
            setState(() {
              countButton++;
              if (countButton > 500) {
                countButton = 0;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenLogin(isback: true)));
              }
            });
          },
        ));
  }

  finishQuestion() {
    final questionsProvider =
        Provider.of<QuestionsProvider>(context, listen: false);
    setState(() => stateFinish = true);
    Timer(const Duration(seconds: 2), () {
      setState(() => stateFinish = false);
      questionsProvider.updatedIdQuestion(0);
    });
  }

  nextQuestion(String data) {
    final questionsProvider =
        Provider.of<QuestionsProvider>(context, listen: false);
    final answersProvider =
        Provider.of<AnswersProvider>(context, listen: false);
    int idQst = questionsProvider.getIdQuestion;
    setState(() => buttonState = false);
    Timer(const Duration(milliseconds: 500), () async {
      if (data.isNotEmpty) {
        var idAnswer = await DBProvider.db.newAnswerModel(AnswerModel(
            idQuestion: questionsProvider.questions[idQst].idQuestion,
            idSurvey: questionsProvider.questions[idQst].idSurvey,
            idTypeAnswer: questionsProvider.questions[idQst].idTypeAnswer,
            answer: data,
            date: DateTime.now().toString()));
        await DBProvider.db
            .getAnswerModelById(idAnswer)
            .then((result) => answersProvider.addAnswers(result));
      }
      setState(() => coment.text = '');
      debugPrint('PREGUNTA NUMERO ${questionsProvider.getIdQuestion}');
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
          overlays: []);
      if (questionsProvider.getIdQuestion <
          (questionsProvider.questions.length - 1)) {
        debugPrint('AUN HAY MAS PREGUNTAS');
        questionsProvider
            .updatedIdQuestion(questionsProvider.getIdQuestion + 1);
        setState(() {
          _controller.restart();
          buttonState = true;
        });
      } else {
        debugPrint('LO ULTIMO');
        setState(() => stateFinish = true);
        Timer(const Duration(seconds: 2), () {
          setState(() => stateFinish = false);
          questionsProvider.updatedIdQuestion(0);
          setState(() => buttonState = true);
        });
      }
    });
  }
}
