import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/view/result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/constants.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dmvquizapp/controller/quiz_class.dart' as quiz;

class QuizScreen extends StatefulWidget {
  static const String id = 'quiz_screen';
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  //var quesInstance = Quiz

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLogoBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
          padding: EdgeInsets.only(
              top: 30,
          ),
              child: Center(
                child: kCircularCountDownTimer(),
                //kCustomText(
                  //text: 'TIMER',
                  //textSize: 30,
                //),
              ),
          ),

          kCustomText(
              text: 'Question ${quiz.Quiz.getQuesNum()}/20',
              textSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0x44000000),
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: 25.0,
              bottom: 15.0,
            ),
            child: kDash(context),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  right: kQuizScreenLeftRightPadding,
                  left: kQuizScreenLeftRightPadding,
              ),
              child: Container(
                  color: kLogoBackgroundColor,
                  child: kCustomText(
                    text: 'An illegal passing zone is indicated by which of the following?',
                    textSize: 25.0,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.bold
                  ),
              ),
            ),
          ),

          Expanded(child: Container(
            color: kLogoBackgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Expanded(
                  child: kOptionButton(
                      text: 'A dashed yellow line',
                    onPressed: (){
                        setState(() {
                          quiz.Quiz.increaseQuesNum();
                          Navigator.pushNamed(context, ResultScreen.id);
                        });
                    }
                  ),
                ),

                Expanded(
                  child: kOptionButton(
                    text: 'A double yellow line',
                      onPressed: (){
                        setState(() {
                          quiz.Quiz.increaseQuesNum();
                        });
                      }
                  ),
                ),

                Expanded(
                  child: kOptionButton(
                    text: 'A dashed white line',
                      onPressed: (){
                        setState(() {
                          quiz.Quiz.increaseQuesNum();
                        });
                      }
                  ),
                ),

                Expanded(
                  child: kOptionButton(
                    text: 'A double white line',
                      onPressed: (){
                        setState(() {
                          quiz.Quiz.increaseQuesNum();
                        });
                      }
                  ),
                ),
              ],
            ),
          ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          )
        ],
      ),
    );
  }
}