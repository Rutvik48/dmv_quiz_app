import 'package:dmvquizapp/view/bottomNavigationBar.dart';
import 'package:dmvquizapp/view/quiz_screen.dart';
import 'package:dmvquizapp/view/result_screen.dart';
import 'package:dmvquizapp/view/topic_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/constants.dart';
import 'quiz_screen.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/controller/firestore_class.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: kCustomText(text: 'This is User Page', minFontSize: 30.0),));
  }
}

