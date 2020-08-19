import 'package:flutter/foundation.dart';

class Quiz {
  String _ques;
  String _op1;
  String _op2;
  String _op3;
  String _op4;
  static int _quesNumber = 0;

  Quiz({String question,
      @required String option1,
      @required String option2,
      @required String option3,
      @required String option4}){

    this._ques = question;
    this._op1 = option1;
    this._op2 = option2;
    this._op3 = option3;
    this._op4 = option4;
  }


  static int getQuesNum(){
    return _quesNumber;
  }

  static void increaseQuesNum(){
    _quesNumber++;
  }

}