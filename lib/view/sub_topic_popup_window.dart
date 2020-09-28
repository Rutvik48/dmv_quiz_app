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
  static final firestoreSingleton = FireStoreClass();
  static Map subTopicList = new Map();
  static List subTopicKeys = new List();
  static bool setStateCalled = false;

  SubTopicPopupWindow({@required selectedMainTopic});
}

class _SubTopicPopupWindowState extends State<SubTopicPopupWindow> {
  static List topicValues = new List();

  void fillSubTopicList ({@required String selectedMainTopic}) async {
    print('fillSubTopicList called');
    SubTopicPopupWindow.subTopicList = await SubTopicPopupWindow.firestoreSingleton.getSubTopics(SubTopicPopupWindow.selectedMainTopic);

    print('Outside: ${SubTopicPopupWindow.subTopicList}');

    SubTopicPopupWindow.subTopicKeys = SubTopicPopupWindow.subTopicList.keys.toList();

    if (!SubTopicPopupWindow.setStateCalled){
      setState(() {
        getScaffoldBody();
      });

      SubTopicPopupWindow.setStateCalled = true;
    }

    //build(context);
    //subTopicKeys = subTopicList.keys.toList();
//    setState(() {
//      //subTopicKeys = subTopicList.keys.toList();
//      //fillListView();
//
//    });
  }

  void getSubTopicListWidget({@required String selectedMainTopic }) {

    print('getSubTopicListWidget called');

    fillSubTopicList(selectedMainTopic: selectedMainTopic);
  }

  Widget fillListView() {
    print('fillListView called');
    //return Container();
    return ListView.builder(

        itemCount: SubTopicPopupWindow.subTopicList.length,
        itemBuilder: (BuildContext context, int index) {

          String key = SubTopicPopupWindow.subTopicKeys[index];
          String text = SubTopicPopupWindow.subTopicList[key];
//          return Container(
//            color: Colors.red,
//            child: SizedBox(
//              height: 500.0,
//              width: 500.0,
//
//            ),
//
           return Container(
             child: SizedBox(
               height: 80.0,
               child: kOptionButton(
                 text: text,
                 fontSize: kOptionsMaxFontSize ,
                 width: 2 ,
                 onPressed: (){
                   SubTopicPopupWindow.firestoreSingleton.setSelectedTopic(key);
                   Navigator.pushNamed(context, QuizScreen.id);
                   //print('This is SubTopics: ${firestoreSingleton.getSubTopics(key)}');
                   //print('This is Key: $key') ;
                   //both sowPopupWindow and createPopupWindow
                   //Navigator.pushNamed(context, QuizScreen.id);
                 },
               ),
             ),
           );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    print('build called');
    //return Container();
    //return fillListView();
    getSubTopicListWidget(selectedMainTopic: SubTopicPopupWindow.selectedMainTopic);
    return Scaffold(
      backgroundColor: Colors.transparent,
        body: getScaffoldBody());
//    return Container(
//          key: GlobalKey(),
//          padding: EdgeInsets.all(10),
//          height: MediaQuery.of(context).size.height * 0.80,
//          width: MediaQuery.of(context).size.width * 0.80,
//          color: pageColor,
//          //child: test(),
//          //child: getTopicListWidget(),
//
//          //child: getSubTopicListWidget(selectedMainTopic: key),
//        );
  }

  Widget getScaffoldBody() {
    return fillListView();
  }
}
