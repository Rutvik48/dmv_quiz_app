import 'package:dmvquizapp/view/bottomNavigationBar.dart';
import 'package:dmvquizapp/view/quiz_screen.dart';
import 'package:dmvquizapp/view/result_screen.dart';
import 'package:dmvquizapp/view/topic_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/constants.dart';
import 'quiz_screen.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/controller/firebase/firestore_class.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: kCustomText(text: 'This is About Page', minFontSize: 30.0),));
  }
}
