import 'package:auto_size_text/auto_size_text.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/view/result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/controller/quiz_class.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:dmvquizapp/controller/quiz_screen_custom_widgets.dart';

class QuizScreen extends StatefulWidget {
  static const String id = 'quiz_screen';

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var quizSingleton = new Quiz();
  String question = '';
  List options = new List();
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String option4 = '';
  String answer = '';
  bool optionClicked = false;
  int totalNumberOfQuestions = 0;
  Color defaultOptionBorderColor = kOptionBorderColor;
  Color correctAnswerBorderColor = kCorrectAnswerOptionBorderColor;
  Color wrongAnswerBorderColor = kWrongAnswerOptionBorderColor;
  Color option1BorderColor= kOptionBorderColor;
  Color option2BorderColor=kOptionBorderColor;
  Color option3BorderColor=kOptionBorderColor;
  Color option4BorderColor=kOptionBorderColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doInitialSetup();
  }

  void doInitialSetup() async {
    await quizSingleton.fillQuizBank('topic');
    setState(() {
      changeQuestion();
      totalNumberOfQuestions = quizSingleton.getTotalNumberOfQuestion();
    });
  }

  void changeQuestion() {
    setState(() {
      resetOptionsBorderColor();
      question = quizSingleton.getQuestion();
      options = quizSingleton.getOptions();
      option1 = options[0];
      option2 = options[1];
      option3 = options[2];
      option4 = options[3];

      optionClicked = false;
    });
  }

  void resetOptionsBorderColor (){
    option1BorderColor = defaultOptionBorderColor;
    option2BorderColor = defaultOptionBorderColor;
    option3BorderColor = defaultOptionBorderColor;
    option4BorderColor = defaultOptionBorderColor;
  }

  void checkAnswer({@required String clickedOption, int optionNumber}) {

    bool result = quizSingleton.checkAnswer(clickedOption);
    print("Check Answer: $result");
    int correctAnswerOption = getAnswerOption(clickedOption);

    setState(() {
      optionClicked = true;

      if (result){
        //selected answer is correct
        quizSingleton.increaseCorrectAnswerCount();

      } else {
        //Selected answer is wrong
        //borderColorTest = Colors.yellowAccent;

        switch (optionNumber){
          case 1:
            option1BorderColor = wrongAnswerBorderColor;
            break;
          case 2:
            option2BorderColor = wrongAnswerBorderColor;
            break;
          case 3:
            option3BorderColor = wrongAnswerBorderColor;
            break;
          case 4:
            option4BorderColor = wrongAnswerBorderColor;
            break;
        }

      }

      switch (correctAnswerOption){
        case 1:
          option1BorderColor = correctAnswerBorderColor;
          break;
        case 2:
          option2BorderColor = correctAnswerBorderColor;
          break;
        case 3:
          option3BorderColor = correctAnswerBorderColor;
          break;
        case 4:
          option4BorderColor = correctAnswerBorderColor;
          break;
      }

    });
  }

  int getAnswerOption (String clickedOption){

    String correctAnswer = quizSingleton.getAnswer();

    if (option1 == correctAnswer){
      //Option 1 has correct answer text
      return 1;

    } else if (option2 == correctAnswer){
      //Option 2 has correct answer text
      return 2;

    } else if (option3 == correctAnswer){
      //Option 3 has correct answer text
      return 3;
    } else {
      //Option 4 has correct answer text
      return 4;
    }
  }

  void goToResultScreen() {
    Navigator.pushNamed(context, ResultScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLogoBackgroundColor,
      body: SafeArea(child: mainColumn(context)),
    );
  }

  Column mainColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (kShowTimer) timer(),

        //getExitAndSkipButton(),

        //getSizedBox(withHeight: 20.0),

        questionNumberHeader(totalQuestions: totalNumberOfQuestions, context: context),

        kDash(context),

        questionWidget(questionText: question),

        kDash(context),

        optionsWidget(),
//        SizedBox(
//          height: MediaQuery.of(context).size.height / 10,
//        ),

        getNextButtonWidget()
      ],
    );
  }



  Widget questionNumberHeader({@required int totalQuestions, @required BuildContext context, @required Function function}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [

          getExitButton(context: context),

          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.center,
              child: kCustomText(
                text: 'Question ${Quiz.getQuesNum()}/$totalQuestions',
                //textSize: 30,
                minFontSize: kQuestionNumberTextFontSize,
                maxFontSize: kQuestionNumberTextFontSize,
                fontWeight: FontWeight.bold,
                color: kQuestionNumberTextColor,
              ),
            ),
          ),
          getSkipButton(context: context, function: function),
        ],
      ),
    );
  }

  Expanded getSkipButton({@required BuildContext context,Function function()}) {
    return Expanded(
      child: Align(
        child: IconButton(
          icon: Icon(
            LineAwesomeIcons.arrow_circle_o_right,
            size: 40.0,
            color: kLogoMatchingColor,
          ),
          onPressed: (){
            print('Skip Button pressed.');

            nextQuestion();
            kShowToast(toastMessage: "Question Skipped");

          },
        ),//Icons()LineAwesomeIcons.
        alignment: Alignment.topRight,
      ),
    );
  }

  //Options
  Expanded optionsWidget() {
    return Expanded(
      child: Container(
        color: kLogoBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: getOption1(),
            ),
            Expanded(
              child:getOption2(),
            ),
            Expanded(
              child: getOption3(),
            ),
            Expanded(
              child: getOption4(),
            ),
          ],
        ),
      ),
    );
  }


  Widget getOption1 ({Color borderColor=kLogoMatchingColor}){
    return getOptionButton(
        optionText: option1,
        borderColor: option1BorderColor,
        onPressed: () {
          if(!optionClicked){
            checkAnswer(clickedOption: option1,optionNumber: 1);
          }
        });
  }

  Widget getOption2 ({Color borderColor=kLogoMatchingColor}){
    return getOptionButton(
        optionText: option2,
        borderColor: option2BorderColor,
        onPressed: () {
          if(!optionClicked){
            checkAnswer(clickedOption: option2,optionNumber: 2);
          }
        });
  }

  Widget getOption3 ({Color borderColor=kLogoMatchingColor}){
    return getOptionButton(
        optionText: option3,
        borderColor: option3BorderColor,
        onPressed: () {
          if(!optionClicked){
            checkAnswer(clickedOption: option3,optionNumber: 3);
          }
        });
  }

  Widget getOption4 ({Color borderColor=kLogoMatchingColor}){
    return getOptionButton(
        optionText: option4,
        borderColor: option4BorderColor,
        onPressed: () {
          if(!optionClicked){
            checkAnswer(clickedOption: option4,optionNumber: 4);
          }
        });
  }

  void nextQuestion(){
    ///'increaseQuesNum()' returns a boolean. When return false goToResultScreen
    if (quizSingleton.increaseQuesNum()){
      changeQuestion();
    } else {
      goToResultScreen();
    }
  }

  RaisedButton _kCustomRaisedButton() {
    return RaisedButton(
      onPressed: () {
        nextQuestion();
      },
      child: Padding(
        padding: EdgeInsets.only(left: 35, right: 35, top: 25, bottom: 25),
        child: kCustomText(
          text: 'Next',
          minFontSize: kNextButtonFontSize,
          fontWeight: FontWeight.w900,
          //color: kNextButtonTextColor,
          color: kLogoBackgroundColor,
        ),
      ),
      color: kQuestionTextColor,
      textColor: Colors.white,
      elevation: 8,
      //Creates circular edge on the top left corner of the Start button
      shape: RoundedRectangleBorder(
        borderRadius:
        new BorderRadius.only(topLeft: Radius.circular(50.0)),
      ),
    );
  }


  Visibility getNextButtonWidget() {
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: optionClicked,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Align(
          //Child will be at bottom right
          alignment: Alignment.bottomRight,

          child: _kCustomRaisedButton(),
        ),
      ),
    );
  }

}
