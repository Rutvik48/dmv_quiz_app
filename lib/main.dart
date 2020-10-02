import 'package:dmvquizapp/view/bottomNavigationBar.dart';
import 'package:dmvquizapp/view/topic_screen.dart';
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
    // return MaterialApp(
    //   home: AppBottomNavigationBar(),
    // );

    return MaterialApp(
      initialRoute: AppBottomNavigationBar.idToHomeScreen,
      routes: {
        AppBottomNavigationBar.idToHomeScreen: (context) =>AppBottomNavigationBar(indexNumber: 0),
        AppBottomNavigationBar.idToTopicScreen: (context) =>AppBottomNavigationBar(indexNumber: 3),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        TopicScreen.id: (context) => TopicScreen(),
        QuizScreen.id: (context) => QuizScreen(),
        ResultScreen.id: (context) => ResultScreen(),
      },
    );
  }
}