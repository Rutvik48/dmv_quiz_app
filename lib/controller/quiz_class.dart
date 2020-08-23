import 'package:flutter/foundation.dart';

class Quiz {
  String _question;
  String _op1;
  String _op2;
  String _op3;
  String _op4;
  String _ans;
  static int _quesNumber = 0;

//  Quiz({String question,
//      @required String option1,
//      @required String option2,
//      @required String option3,
//      @required String option4}){
//
//    this._ques = question;
//    this._op1 = option1;
//    this._op2 = option2;
//    this._op3 = option3;
//    this._op4 = option4;
//  }


  static int getQuesNum(){
    return _quesNumber;
  }

  static void increaseQuesNum(){
    _quesNumber++;
  }

  String getQuestion(){
    return _question;
  }

  List getOptions(){
    return _randomizeOptions([_op1, _op2, _op3, _op4]);
  }

  List<dynamic> _randomizeOptions(List list){
    list.shuffle();
    return list;
  }

  bool checkAnswer(String clickedOption) {
    //Checking if answer pressed by user is same as answer. if yes returns true, else false
    return (clickedOption == _ans);
  }


}