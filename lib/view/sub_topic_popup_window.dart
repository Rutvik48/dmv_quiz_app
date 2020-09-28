import 'dart:io';

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

class SubTopicPopupWindow extends StatefulWidget {
  @override
  _SubTopicPopupWindowState createState() => _SubTopicPopupWindowState();

  static String selectedMainTopic;
  SubTopicPopupWindow({@required selectedMainTopic});
}

class _SubTopicPopupWindowState extends State<SubTopicPopupWindow> {
  Color pageColor = Colors.amber;
  var arrayOfColor = [Colors.red,Colors.white,Colors.pink,Colors.blue,Colors.yellow,Colors.red,Colors.white,Colors.pink,Colors.blue,Colors.yellow,Colors.red,Colors.white,Colors.pink,Colors.blue,Colors.yellow];

  @override
  Widget build(BuildContext context) {
    return Container(
          key: GlobalKey(),
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.80,
          width: MediaQuery.of(context).size.width * 0.80,
          color: pageColor,
          child: test(),
          //child: getTopicListWidget(),

          //child: getSubTopicListWidget(selectedMainTopic: key),
        );
  }

  Widget test(){
    testing();
  }

  Future<void> testing () async{

    for(int i = 0; i < 10000; i++ ){
      await Future.delayed(Duration(seconds: 3));
      pageColor = arrayOfColor[i];
      i++;
      setState(() {
        build(context);
      });

      await Future.delayed(Duration(seconds: 3));
      pageColor = arrayOfColor[i];
      i++;
      setState(() {
        build(context);
      });
      await Future.delayed(Duration(seconds: 3));
      pageColor = arrayOfColor[i];
      i++;
      setState(() {
        build(context);
      });
      await Future.delayed(Duration(seconds: 3));
      pageColor = arrayOfColor[i];
      i++;
      setState(() {
        build(context);
      });
      await Future.delayed(Duration(seconds: 3));
      pageColor = arrayOfColor[i];
      i++;
      setState(() {
        build(context);
      });
      await Future.delayed(Duration(seconds: 3));
      pageColor = arrayOfColor[i];
      i++;
      setState(() {
        build(context);
      });
      await Future.delayed(Duration(seconds: 3));
      pageColor = arrayOfColor[i];
      i++;
      setState(() {
        build(context);
      });

    }
  }
}
