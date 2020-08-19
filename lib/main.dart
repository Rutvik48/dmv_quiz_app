import 'package:flutter/material.dart';
import 'package:dmvquizapp/view/welcom_screen.dart';
import 'package:dmvquizapp/view/quiz_screen.dart';
import 'package:dmvquizapp/view/result_screen.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        QuizScreen.id: (context) => QuizScreen(),
        ResultScreen.id: (context) => ResultScreen(),
      },
    );
  }
}
