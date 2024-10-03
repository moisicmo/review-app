import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:review/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:review/src/check_auth_screen.dart';
import 'package:review/src/screens/login.dart';
import 'package:review/provider/answersData.dart';
import 'package:review/provider/questionsData.dart';
import 'package:review/provider/surveysData.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => AuthService()),
                ChangeNotifierProvider(create: (_) => QuestionsProvider()),
                ChangeNotifierProvider(create: (_) => SurveysProvider()),
                ChangeNotifierProvider(create: (_) => AnswersProvider()),
              ],
              child: MaterialApp(
                  theme: ThemeData(
                    fontFamily: "unifranz",
                    brightness: Brightness.light,
                    primaryColor: const Color(0xffF26522),
                    scaffoldBackgroundColor: const Color(0xfff2f2f2),
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    buttonTheme: ButtonThemeData(
                        padding: const EdgeInsets.all(0),
                        splashColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        textTheme: ButtonTextTheme.accent),
                  ),
                  title: 'UNIFRANZ REVIEW',
                  debugShowCheckedModeBanner: false,
                  initialRoute: 'checking',
                  routes: {
                    'checking': (_) => const CheckAuthScreen(),
                    'login': (_) => const ScreenLogin(),
                  }),
            ));
  }
}
