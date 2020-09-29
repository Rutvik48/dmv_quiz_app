import 'package:dmvquizapp/view/quiz_screen.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    doInitialSetup();
  }

  void doInitialSetup() async {
    await fillSubTopicList(
        selectedMainTopic: SubTopicPopupWindow.selectedMainTopic);
    setState(() {});
  }

  Future<void> fillSubTopicList({@required String selectedMainTopic}) async {
    print('fillSubTopicList called');
    SubTopicPopupWindow.subTopicList = await SubTopicPopupWindow
        .firestoreSingleton
        .getSubTopics(SubTopicPopupWindow.selectedMainTopic);

    print('Outside: ${SubTopicPopupWindow.subTopicList}');

    SubTopicPopupWindow.subTopicKeys =
        SubTopicPopupWindow.subTopicList.keys.toList();

    if (!SubTopicPopupWindow.setStateCalled) {
      setState(() {
        getScaffoldBody();
      });

      SubTopicPopupWindow.setStateCalled = true;
    }
  }

  Widget fillListView() {
    print('fillListView called');
    //return Container();
    return ListView.builder(
        shrinkWrap: true,
        itemCount: SubTopicPopupWindow.subTopicList.length,
        itemBuilder: (BuildContext context, int index) {
          String key = SubTopicPopupWindow.subTopicKeys[index];
          String text = SubTopicPopupWindow.subTopicList[key];

          return SizedBox(
            height: 80.0,
            child: kOptionButton(
              text: text,
              fontSize: kOptionsMaxFontSize,
              borderWidth: 2,
              onPressed: () {
                SubTopicPopupWindow.firestoreSingleton.setSelectedTopic(key);
                Navigator.pushNamed(context, QuizScreen.id);
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print('build called');
    return Scaffold(
        backgroundColor: Colors.transparent, body: getScaffoldBody());
  }

  Widget getScaffoldBody() {
    return Center(child: fillListView());
  }
}
