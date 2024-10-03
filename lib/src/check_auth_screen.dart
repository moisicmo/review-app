import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review/provider/answersData.dart';
import 'package:review/provider/db_provider.dart';
import 'package:review/provider/questionsData.dart';
import 'package:review/services/auth_service.dart';
import 'package:review/services/sendData.dart';
import 'package:review/services/update.dart';
import 'package:review/src/screens/login.dart';
import 'package:review/src/screens/surveys/questions.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readQuestions(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return const Text('');

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const ScreenLogin(),
                        transitionDuration: const Duration(seconds: 0)));
              });
            } else {
              existQuestion(context);
            }

            return Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        width: size.width / 2,
                        child: Center(
                            child: Image.asset("assets/icons/favico.png"))),
                    const CircularProgressIndicator()
                  ],
                ));
          },
        ),
      ),
    );
  }

  existQuestion(context) async {
    final answersProvider =
        Provider.of<AnswersProvider>(context, listen: false);
    final questionsProvider =
        Provider.of<QuestionsProvider>(context, listen: false);
    //actualizar
    await update(context);
    debugPrint('RESPUESTAS!!!!!! ${answersProvider.answers.length}');
    if (answersProvider.answers.isEmpty) {
      await sendData(context);
      await DBProvider.db
          .getALLAnswers()
          .then((res) => answersProvider.updateAnswers(res));
      await DBProvider.db
          .getALLQuestions()
          .then((res) => questionsProvider.updateQuestions(res))
          .then((value) => {
                Future.microtask(() {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const PageQuestions(),
                          transitionDuration: const Duration(seconds: 0)));
                })
              });
    } else {
      await sendData(context);
    }
  }
}
