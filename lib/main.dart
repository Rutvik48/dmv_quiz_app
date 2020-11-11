import 'package:dmvquizapp/view/bottomNavigationBar.dart';
import 'package:dmvquizapp/view/login_screen.dart';
import 'package:dmvquizapp/view/signup_screen.dart';
import 'package:dmvquizapp/view/topic_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/view/welcom_screen.dart';
import 'package:dmvquizapp/view/quiz_screen.dart';
import 'package:dmvquizapp/view/result_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {

  QuizApp() {
    print(' 1. in QuizApp constructor Called QuizApp() from main()');
    initialSetup();
    //Firebase.initializeApp();
  }

  void initialSetup() async {
    print('2. Initialization Started');
    //await Firebase.initializeApp();
    print('3. Initialization completed');
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: AppBottomNavigationBar(),
    // );

    print('4. in Build Called QuizApp() from main()');
    return MaterialApp(
      initialRoute: AppBottomNavigationBar.idToHomeScreen,
      routes: {
        AppBottomNavigationBar.idToHomeScreen: (context) =>AppBottomNavigationBar(indexNumber: 0),
        AppBottomNavigationBar.idToTopicScreen: (context) =>AppBottomNavigationBar(indexNumber: 3),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        TopicScreen.id: (context) => TopicScreen(),
        QuizScreen.id: (context) => QuizScreen(),
        ResultScreen.id: (context) => ResultScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
      },
    );
  }
}