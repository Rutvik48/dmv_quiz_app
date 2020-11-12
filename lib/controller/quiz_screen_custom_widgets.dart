import 'package:flutter/cupertino.dart';
import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/view/result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/controller/quiz_class.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:dmvquizapp/controller/quiz_screen_custom_widgets.dart';
import 'package:dmvquizapp/view/bottomNavigationBar.dart';



SizedBox getSizedBox({double withHeight=0, double withWidth=0}){
  return SizedBox(
    height: withHeight,
    width: withWidth,
  );
}

Expanded getExitButton({@required BuildContext context}) {
  return Expanded(
    child: Align(
      child: IconButton(
        icon: Icon(
          LineAwesomeIcons.arrow_circle_left,
          size: 40.0,
          color: kLogoMatchingColor,
        ),
        onPressed: (){
          print('Exit Button pressed. 1');
          showExitDialog(context: context);
        },
      ),//Icons()LineAwesomeIcons.
      alignment: Alignment.topLeft,
    ),
  );
}


void showExitDialog({@required BuildContext context}) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Exit'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('You will lose points earned in this round.'),
              //Text('Click  to exit'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Continue Playing'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

          FlatButton(
            child: Text('Exit'),
            onPressed: () {
              Navigator.of(context).pop();
              //TODO: If points are being added while user is playing, make sure to not save it on firestore
              ///Pressing yes means exiting the round, so points shouldn't be saved
              Navigator.pushNamed(context, AppBottomNavigationBar.idToHomeScreen);
            },
          ),
        ],
      );
    },
  );
}

Padding timer() {
  return Padding(
    padding: EdgeInsets.only(
      top: 30,
    ),
    child: Center(
      child: kCircularCountDownTimer(),
    ),
  );
}

///Question Widget shows question on the screen
Expanded questionWidget({@required String questionText}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.only(
        right: kQuizScreenLeftRightPadding,
        left: kQuizScreenLeftRightPadding,
      ),
      child: Center(
        child: Container(
          color: kLogoBackgroundColor,
          child: Center(
            child: kCustomText(
                text: questionText,
                color: kQuestionTextColor,
                maxFontSize: kQuestionTextMaxFontSize,
                minFontSize: kQuestionTextMinFontSize,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

Widget getOptionButton({@required String optionText, @required Function onPressed, Color borderColor}) {
  return kOptionButton(
    text: optionText,
    onPressed: onPressed,
    borderColor: borderColor,
  );
}

