import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dmvquizapp/controller/firebase_constants.dart';
import 'package:dmvquizapp/view/quiz_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dmvquizapp/controller/firestore_class.dart';

class Quiz {
  static final Quiz _singleton = Quiz._internal();

  factory Quiz() => _singleton;

  Quiz._internal();

  String _question;
  String _op1;
  String _op2;
  String _op3;
  String _op4;
  String _ans;
  static int _questionCounter = 0;
  int _totalQuestions = 0;
  Map _quizBank = new Map<int, Map<String, dynamic>>();
  int _correctAnswerCount = 0;

  //List holds random number from 0 to 'totalQuestions'
  //Used to randomize list of questions
  var questionNumberList;

  var firebaseInstance = FireStoreClass();

  static int getQuesNum() {
    return (_questionCounter + 1);
  }

  int getTotalNumberOfQuestion() {
    return _totalQuestions + 1;
  }

  void resetData() {
    //_singleton = new Quiz();
    _questionCounter = 0;
    _correctAnswerCount = 0;
    _quizBank.clear();
  }

  bool increaseQuesNum() {
    if (_questionCounter < (_totalQuestions)) {
      _questionCounter++;
      print(
          "Question Counter: $_questionCounter \nTotal Question: $_totalQuestions");
      return true;
    } else {
      return false;
    }
  }

  void increaseCorrectAnswerCount() {
    _correctAnswerCount++;
  }

  int getCorrectAnswerCount() {
    return _correctAnswerCount;
  }

  String getQuestion() {
    _question = this._quizBank[questionNumberList[_questionCounter]]
        [FIREBASE_FIELD_QUESTION];

    return _question;
  }

  List getOptions() {
    _op1 = this._quizBank[questionNumberList[_questionCounter]]
        [FIREBASE_FIELD_OPTION1];
    _op2 = this._quizBank[questionNumberList[_questionCounter]]
        [FIREBASE_FIELD_OPTION2];
    _op3 = this._quizBank[questionNumberList[_questionCounter]]
        [FIREBASE_FIELD_OPTION3];
    _op4 = this._quizBank[questionNumberList[_questionCounter]]
        [FIREBASE_FIELD_OPTION4];

    return _randomizeOptions([_op1, _op2, _op3, _op4]);
  }

  List<dynamic> _randomizeOptions(List list) {
    list.shuffle();
    return list;
  }

  bool checkAnswer(String clickedOption) {
    _ans = this._quizBank[questionNumberList[_questionCounter]]
        [FIREBASE_FIELD_ANSWER];
    _ans = _ans.replaceAll("\n", "").trim();

    //Checking if answer pressed by user is same as answer. if yes returns true, else false
    return (clickedOption == _ans);
  }

  String getAnswer() {
    return _ans;
  }

  Future<void> fillQuizBank(String selectedTopic) async {
    //_quizBank.clear;
    //TODO: Change selectedTopic in the function call
    this._quizBank = await firebaseInstance.getQuestion(
        subCollectionName: 'traffic_controll');

    _totalQuestions = _quizBank.length - 1;

    //Based on total number of question, creating a list 0 to 'totalQuestions'
    questionNumberList = new List<int>.generate(_totalQuestions + 1, (i) => i);

    //Shuffling the list to randomize list which will be used to pick question
    questionNumberList.shuffle();
  }
}
