import 'package:auto_size_text/auto_size_text.dart';
import 'package:dmvquizapp/view/quiz_screen.dart';
import 'package:dmvquizapp/view/sub_topic_popup_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/constants.dart';
import 'quiz_screen.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/controller/firestore_class.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

class TopicScreen extends StatefulWidget {
  @override
  _TopicScreenState createState() => _TopicScreenState();


  static const String id = 'topic_screen';
}

class _TopicScreenState extends State<TopicScreen> {
  static final firestoreSingleton = FireStoreClass();
  static Map mainTopicList = new Map();
  static List mainTopicKeys = new List();
  static Map subTopicList = new Map();
  static List subTopicKeys = new List();
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

    mainTopicKeys = mainTopicList.keys.toList();
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
                itemCount: mainTopicList.length,
                itemBuilder: (BuildContext context, int index) {

                  String key = mainTopicKeys[index];
                  String text = mainTopicList[key];

                  return SizedBox(
                    height: 80.0,
                    child: kOptionButton(
                      text: text,
                      fontSize: kOptionsMaxFontSize ,
                      width: 2 ,
                      onPressed: (){
                        firestoreSingleton.setSelectedTopic(key);
                        //print('This is SubTopics: ${firestoreSingleton.getSubTopics(key)}');
                        //print('This is Key: $key') ;
                        //both sowPopupWindow and createPopupWindow
                        showPopupWindow(
                          context,
                          gravity: KumiPopupGravity.center,
                          bgColor: Colors.grey.withOpacity(0.5),
                          clickOutDismiss: true,
                          clickBackDismiss: true,
                          customAnimation: false,
                          customPop: false,
                          customPage: false,
                          //targetRenderBox: (btnKey.currentContext.findRenderObject() as RenderBox),
                          //childSize: null,
                          underStatusBar: false,
                          underAppBar: true,
                          //offsetX: 0,
                          //offsetY: 0,
                          duration: Duration(milliseconds: 200),
                          onShowStart: (pop) {
                            print("showStart");
                          },
                          onShowFinish: (pop) {
                            print("showFinish");
                          },
                          onDismissStart: (pop) {
                            print("dismissStart");
                          },
                          onDismissFinish: (pop) {
                            print("dismissFinish");
                          },
                          onClickOut: (pop){
                            print("onClickOut");
                          },
                          onClickBack: (pop){
                            print("onClickBack");
                          },
                          childFun: (pop) {
                            //return SubTopicPopupWindow(selectedMainTopic: '1',);
                            return Container(
                              key: GlobalKey(),
                              padding: EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.80,
                              width: MediaQuery.of(context).size.width * 0.80,
                              color: Colors.yellow,
                              //child: getTopicListWidget(),
                              child: SubTopicPopupWindow(selectedMainTopic: '1',),
                            );
                          },
                          // childFun: (pop) {
                          //   return SubTopicPopupWindow(selectedMainTopic: '1',);
                          //   // return Container(
                          //   //   key: GlobalKey(),
                          //   //   padding: EdgeInsets.all(10),
                          //   //   height: MediaQuery.of(context).size.height * 0.80,
                          //   //   width: MediaQuery.of(context).size.width * 0.80,
                          //   //   //color: ,
                          //   //   //child: getTopicListWidget(),
                          //   //   child: getSubTopicListWidget(selectedMainTopic: key),
                          //   // );
                          // },
                        );
                        //Navigator.pushNamed(context, QuizScreen.id);
                      },
                    ),
                  );
                }
            );
  }

  Widget getSubTopicListWidget({@required String selectedMainTopic }) {

    //fillSubTopicList(selectedMainTopic: selectedMainTopic);
    test();
    return fillListView();
  }

  ListView fillListView() {
    return ListView.builder(

      itemCount: subTopicList.length,
      itemBuilder: (BuildContext context, int index) {

        String key = subTopicKeys[index];
        String text = subTopicList[key];

        return Container(
          color: Colors.red,
          child: SizedBox(
            height: 500.0,
              width: 500.0,

          ),
        );
        // return SizedBox(
        //   height: 80.0,
        //   child: Container(
        //     color: Colors.red,
        //     child: kOptionButton(
        //       text: text,
        //       fontSize: kOptionsMaxFontSize ,
        //       width: 2 ,
        //       onPressed: (){
        //         firestoreSingleton.setSelectedTopic(key);
        //         //print('This is SubTopics: ${firestoreSingleton.getSubTopics(key)}');
        //         //print('This is Key: $key') ;
        //         //both sowPopupWindow and createPopupWindow
        //         //Navigator.pushNamed(context, QuizScreen.id);
        //       },
        //     ),
        //   ),
        // );
      }
  );
  }

  Future<void> fillTopicList () async {
    mainTopicList = await firestoreSingleton.getTopics();

    print(mainTopicList);

  }

  void test (){
    fillSubTopicList(selectedMainTopic: '1');
    print('test ends');
  }

  Future<void> fillSubTopicList ({@required String selectedMainTopic}) async {
    subTopicList = await firestoreSingleton.getSubTopics(selectedMainTopic)
        .whenComplete(() => {
      subTopicKeys = subTopicList.keys.toList(),
      print('Inside: $subTopicList')

    });

    print('Outside: $subTopicList');

    subTopicKeys = subTopicList.keys.toList();
    setState(() {
      subTopicKeys = subTopicList.keys.toList();
      fillListView();
      build(context);
    });

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