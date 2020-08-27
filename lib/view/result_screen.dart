import 'package:dmvquizapp/controller/constants.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/controller/quiz_class.dart';

class ResultScreen extends StatelessWidget {
  static const String id = 'result_screen';
  final quizSingleton = new Quiz();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: kCustomText(text:'Quiz Result'),
        ),
        body: Center(
          child: Column(
            children: [

              //TODO: Before Scrollview show how many questions were correct
              kCustomText(
                text: "You ansered ${quizSingleton.getCorrectAnswerCount()}/${quizSingleton.getTotalNumberOfQuestion()} correctly",
                fontWeight: FontWeight.bold,
                minFontSize: kQuestionTextMaxFontSize,
              ),

              //TODO: Add Scrollable Page to show questions, answers and what user entered

            ],
          ),
        ),
    );
  }
}
