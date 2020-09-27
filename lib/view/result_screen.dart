import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/view/bottomNavigationBar.dart';
import 'package:dmvquizapp/view/quiz_screen.dart';
import 'package:dmvquizapp/view/welcom_screen.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/controller/quiz_class.dart';

class ResultScreen extends StatefulWidget {
  static const String id = 'result_screen';

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final quizSingleton = new Quiz();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50.0,
              ),

              //TODO: Before Scrollview show how many questions were correct
              kCustomText(
                text:
                    "You answered ${quizSingleton.getCorrectAnswerCount()}/${quizSingleton.getTotalNumberOfQuestion()} correctly",
                fontWeight: FontWeight.bold,
                minFontSize: kQuestionTextMaxFontSize,
              ),

              SizedBox(
                height: 50.0,
              ),
              createButton(
                  context: context,
                  navigatorPath: QuizScreen.id,
                  buttonText: kPlayAgainText),


              //createButton( context, kPlayAgainText, navigatorPath: QuizScreen.id),
              SizedBox(
                height: 50.0,
              ),

              createButton(
                  context: context,
                  navigatorPath: AppBottomNavigationBar.idToTopicScreen,
                  buttonText: kChooseTopicText),
              //createButton(context, kChooseTopicText, TopicScreen.id),
              SizedBox(
                height: 50.0,
              ),

              createButton(
                  context: context,
                  navigatorPath: AppBottomNavigationBar.idToHomeScreen,
                  buttonText: kGoToHomeScreenText),
              //createButton(context, kGoToHomeScreenText, WelcomeScreen.id),
              SizedBox(
                height: 50.0,
              ),

              //TODO: Add Scrollable Page to show questions, answers and what user entered
            ],
          ),
        ),
      ),

      //bottomNavigationBar: AppBottomNavigationBar(),
    );
  }

  SizedBox createButton(
      {@required BuildContext context,
      @required String navigatorPath,
      @required String buttonText}) {
    return SizedBox(
      height: 100.0,
      child: kOptionButton(
          text: buttonText,
          fontSize: 20.0,
          width: 2,
          onPressed: () {
            setState(() {
              Navigator.pushNamed(context, navigatorPath);
              quizSingleton.resetData();
            });
          }),
    );
  }
}
