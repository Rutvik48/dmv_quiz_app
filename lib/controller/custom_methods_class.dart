import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/controller/firebase/firebase_auth_class.dart';
import 'package:dmvquizapp/controller/firebase/firestore_class.dart';
import 'package:dmvquizapp/view/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:dmvquizapp/controller/sign_in_class.dart';



String filterText(String text){
  String filteredText;

  if (!isTextEmpty(text)){
    filteredText = text.trim();
    filteredText = text.replaceAll('\n', '');
  }else {
    throw Exception('Text is Empty');
  }

  return filteredText;
}


bool isTextEmpty(String text){

  if (text == null){
    return true;
  } else {
    return false;
  }

}