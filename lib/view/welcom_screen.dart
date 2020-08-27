import 'package:dmvquizapp/view/quiz_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/constants.dart';
import 'quiz_screen.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/controller/firebase_connection.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _State createState() => _State();
}

class _State extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kLogoBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,

          children: <Widget>[
            //Expended widget takes as much space as possible
            Expanded(child: Image.asset(kWelcomeScreenLogoPath),flex: 2,),
            Expanded(
                child: kCustomText(
                  text: kQuizAppName,
                  maxFontSize: kAppNameFontSize,
                  minFontSize: kAppNameFontSize,
                  color: kLogoMatchingColor,
                ),
            ),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: kCustomText(
                      text: kQuizDescription,
                      color: kLogoMatchingColor,
                      maxFontSize: 18,
                  ),
                ),
            ),
            //Align widget is used to place child widget where desired
            Expanded(child: Align(
              //Child will be at bottom right
              alignment: Alignment.bottomRight,

              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, QuizScreen.id);
                  //FireStore_Class().addData();
                  //FireStore_Class().onPressed();

//                  setState(() {
//                    //something
//                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: kCustomText(
                    //textSize: 30,
                    minFontSize: kStartButtonTextSize,
                    maxFontSize: kStartButtonTextSize,
                    text: kStartButtonText,
                  )
                ),
                color: kLogoMatchingColor,
                textColor: Colors.white,
                elevation: 8,
                //Creates circular edge on the top left corner of the Start button
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: kLogoMatchingColorWithLowAlpha,
                      width: 5,
                      style: BorderStyle.solid
                  ),
                  borderRadius: new BorderRadius.only(topLeft: Radius.circular(50.0)),
                ),
              ),
            ),
            )

          ],
        ),
      ),
    );
  }
}
