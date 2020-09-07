import 'package:auto_size_text/auto_size_text.dart';
import 'package:dmvquizapp/view/quiz_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/constants.dart';
import 'quiz_screen.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/controller/firestore_class.dart';

class TopicScreen extends StatefulWidget {
  @override
  _TopicScreenState createState() => _TopicScreenState();


  static const String id = 'topic_screen';
}

class _TopicScreenState extends State<TopicScreen> {
  static final firestoreSingleton = FireStoreClass();
  static Map topicList = new Map();
  static List topicKeys = new List();
  static List topicValues = new List();
  //static Iterable<dynamic> topicKeys;// = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doInitialSetup();
  }

  void doInitialSetup() async {
    await fillTopicList();
    //topicKeys = topicList.keys;
    //print(topicKeys.elementAt(0));

    topicKeys = topicList.keys.toList();
    

    setState(() {
      build(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getHeadingTextWidget(),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: kDash(context),
            ),

            Expanded(
              child: getTopicListWidget(),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
              child: kDash(context),
            ),
          ],
        )
      ),
    );
  }

  ListView getTopicListWidget() {

    return ListView.builder(
                itemCount: topicList.length,
                itemBuilder: (BuildContext context, int index) {

                  String key = topicKeys[index];
                  String text = topicList[key];

                  return SizedBox(
                    height: 80.0,
                    child: kOptionButton(
                      text: text,
                      fontSize: kOptionsMaxFontSize ,
                      onPressed: (){
                        firestoreSingleton.setSelectedTopic(key);
                        Navigator.pushNamed(context, QuizScreen.id);
                      },
                    ),
                  );
                }
            );
  }

  Future<void> fillTopicList () async {
    topicList = await firestoreSingleton.getTopics();

    print(topicList);

  }

  AutoSizeText getHeadingTextWidget() {
    return kCustomText(
            minFontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: kLogoMatchingColor,
            text: 'Chose a Topic',
            textAlign: TextAlign.center,
          );
  }
}