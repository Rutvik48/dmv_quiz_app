import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:flutter/cupertino.dart';

import 'firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//This class holds methods to make changes and retrieve data from Firestore Cloud Database
class FireStoreClass {
  final firestoreInstance = FirebaseFirestore.instance;
  static final FireStoreClass _singleton = FireStoreClass._internal();
  factory FireStoreClass() => _singleton;
  FireStoreClass._internal();

  static String selectedTopic = '';

  void setSelectedTopic(String topic) {
    selectedTopic = topic;
  }

  //Getting Questions from question_main_collection>new_york>[selected topic by user]
  Future<Map> getQuestion({@required String subCollectionName}) async {
    print("Get Data is Called");
    QuerySnapshot questions;
    questions = await firestoreInstance
        .collection(FIREBASE_MAIN_QUIZ_COLLECTION)
        .doc(FIREBASE_MAIN_QUIZ_DOCUMENT)
        ///TODO: Change this collection string to user selected topic
        .collection(selectedTopic)
        .get();
    //print(questions);

    return changeIntoMap(questions);
  }

  //Changing QuerySnapshot into Map<int, Map<String, dynamic>>
  //That will be used to return a Map from different methods that gets data from Firestore
  Map changeIntoMap(QuerySnapshot querySnapshot) {
    Map questionBank = new Map<int, Map<String, dynamic>>();

    int counter = 0;
    print('Filling Question Bank.');
    for (var document in querySnapshot.docs) {
      if (document[FIREBASE_FIELD_QUESTION] != null) {
        //print(document.data());
        questionBank.putIfAbsent(counter, () => document.data());
        counter++;
      }
    }
    return questionBank;
  }

  //Getting list of topics available from Firestore
  //Gets FIREBASE_MAIN_QUIZ_COLLECTION>FIREBASE_MAIN_QUIZ_DOCUMENT>Get all data
  //From all the data, it searches for 'main_topic' [FIREBASE_QUIZ_MAIN_TOPIC_ARRAY]
  Future<Map> getTopics() async {

    DocumentSnapshot documents;
    documents = await _getTopicDocumentSnapshot();

    return changeTopicsIntoMap(documentSnapshot: documents, topicString: FIREBASE_QUIZ_MAIN_TOPIC_ARRAY);
  }

  Future<dynamic> _getTopicDocumentSnapshot() async {
    DocumentSnapshot documents;
    documents = await firestoreInstance
        .collection(FIREBASE_MAIN_QUIZ_COLLECTION)
        .doc(FIREBASE_MAIN_QUIZ_DOCUMENT)
        .get();

    return documents;
  }

  //
  Future<Map> getSubTopics(String selectedMainTopic) async {

    DocumentSnapshot documents;
    print ('Selected Main Topic in getSubTopics $selectedMainTopic');
    print ('Selected Topic in getSubTopics $selectedTopic');
    documents = await firestoreInstance
        .collection(FIREBASE_MAIN_QUIZ_COLLECTION)
        .doc(FIREBASE_MAIN_QUIZ_DOCUMENT)
        .collection(selectedTopic)
        .doc(FIREBASE_QUIZ_SUB_TOPICS_DOCUMENT)
        .get();

    //print(documents);
    return changeSubTopicsIntoMap(documentSnapshot: documents);
  }


  Map createMap({@required DocumentSnapshot documentSnapshot, @required String topicString, trueForTopic=false}) {
    Map topicMap = new Map<String, String>();

    print('This is documentSnapshot.data : \n${documentSnapshot.data}');

    if (trueForTopic){
      documentSnapshot.data().forEach((key, value) {
        if (key == topicString){
          value.forEach((key, value) {
            topicMap[key] = value;
        });}
      });
    } else {
      documentSnapshot.data().forEach((key, value) {
        topicMap[key] = value;
      });
    }

    print('This is topic Map: \n$topicMap');
    return topicMap;
  }

  Map changeTopicsIntoMap({@required DocumentSnapshot documentSnapshot, @required String topicString}) {

    return createMap(documentSnapshot: documentSnapshot, topicString: FIREBASE_QUIZ_MAIN_TOPIC_ARRAY, trueForTopic: true);
  }

  Map changeSubTopicsIntoMap({@required DocumentSnapshot documentSnapshot}) {
    return createMap(documentSnapshot: documentSnapshot, topicString: 'N/A');
  }

  void addUser({
    @required String userEmail,
    @required String firstName,
    String userPicture
  }){

    firestoreInstance.collection(FIREBASE_MAIN_USER_COLLECTION).
    doc(FIREBASE_MAIN_USER_DOCUMENT).
    collection(userEmail).
    doc(FIREBASE_USER_DETAIL_DOCUMENT).set(
      {
        FIREBASE_USER_DETAIL_FIELD_FULL_NAME: firstName,
        //FIREBASE_USER_DETAIL_FIELD_LAST_NAME: lastName,
        FIREBASE_USER_DETAIL_FIELD_USER_PIC: userPicture,
      }
    );
  }

  void addScoreDetail({
    @required int userEmail,
    @required String firstName,
    @required String lastName,
    String userPicture
  }){

    // firestoreInstance.collection(FIREBASE_MAIN_USER_COLLECTION).
    // document(FIREBASE_MAIN_USER_DOCUMENT).
    // collection(userEmail).
    // document(FIREBASE_USER_DETAIL_DOCUMENT).setData(
    //     {
    //       FIREBASE_USER_DETAIL_FIELD_FIRST_NAME: firstName,
    //       FIREBASE_USER_DETAIL_FIELD_LAST_NAME: lastName,
    //       FIREBASE_USER_DETAIL_FIELD_USER_PIC: userPicture,
    //     }
    // );
  }

  Future<int> countTotalNumberOfQuestion () async {
    Future<int> count;

    var docs=await firestoreInstance
        .collection(FIREBASE_MAIN_QUIZ_COLLECTION)
        .doc(FIREBASE_MAIN_QUIZ_DOCUMENT).get();

    //firestoreInstance.
    print ('Document data: ${docs.data()}');
    print ('Document data.length: ${docs.data().length}');


    // int count = await firestoreInstance
    //     .collection(FIREBASE_MAIN_QUIZ_COLLECTION)
    //     .doc(FIREBASE_MAIN_QUIZ_DOCUMENT)
    //     .get();
    // firestoreInstance.collection(FIREBASE_MAIN_USER_COLLECTION).
    // doc(FIREBASE_MAIN_USER_DOCUMENT).
    // collection(userEmail).snapshots().length;

    return count;
  }

  void addData() {
    final firestoreInstance = FirebaseFirestore.instance;
    print("Add Data is called!!");
    firestoreInstance.collection(FIREBASE_MAIN_QUIZ_COLLECTION).add({
      "name": "john",
      "age": 50,
      "email": "example@example.com",
      "address": {"street": "street 24", "city": "new york"}
    }).then((value) {
      print(value.id);
    });
  }
}
