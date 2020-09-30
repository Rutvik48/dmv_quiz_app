import 'package:flutter/material.dart';

const kStartButtonText = 'Start Quiz!';
const kQuizAppName = "Beginner's Driving Academy";
const kQuizDescription = "Address\n129-20 Liberty Avenue (Entrance on 130 street, South Richmond Hill, NY 11419";//"We are dedicated to providing you the best services at great prices. \n"
    //"Our office staff is knowledgeable about NYS Motor Vehicle regulations pertaining to driving.  We can assist you in the licensing process from beginning to end.";
const kWelcomeScreenLogoPath = 'images/dmv_app_icon.jpg';
const kLogoMatchingColor = Color(0xFFea5723);
const kLogoMatchingColorWithLowAlpha = Color.fromARGB(256,234, 185, 142);
const kLogoBackgroundColor = Color(0xFFFFFFFF);
const kQuizScreenLeftRightPadding = 20.0;

//Used for AutoSizeText
///NOTE: When min is specified, it sets font size to minFontSize specified
const double kDefaultMaxFontSize = 30.0;
const double kDefaultMinFontSize = 15.0;

//Welcome Screen constants
///NOTE: When min is specified, it sets font size to minFontSize specified
const double kAppNameFontSize = 35.0;
const double kStartButtonTextSize = 35.0;

//Quiz Screen constants
///NOTE: When min is specified, it sets font size to minFontSize specified
const double kQuestionNumberTextFontSize = 35.0;
const double kQuestionTextMinFontSize = 25.0;
const double kQuestionTextMaxFontSize = 30.0;
const double kOptionsMinFontSize = 16.0;
const double kOptionsMaxFontSize = 25.0;
const double kNextButtonFontSize = 22;

const bool kShowTimer = false;
const double kButtonRadius = 15.0;

const Color kOptionButtonBackgroundColor = Colors.white;
const Color kQuestionNumberTextColor = Color(0x44000000);
const Color kDividerLineColor = kLogoMatchingColor;
const Color kQuestionTextColor = kLogoMatchingColor;
const Color kOptionBorderColor = kQuestionNumberTextColor;
const Color kCorrectAnswerOptionBorderColor = Colors.lightGreen;
const Color kWrongAnswerOptionBorderColor = Colors.deepOrange;
const Color kNextButtonTextColor = Colors.white70;


//Result Screen constants
const String kPlayAgainText = 'Play Again!';
const String kChooseTopicText = 'Choose Another Topic';
const String kGoToHomeScreenText = 'Go to Homepage';


