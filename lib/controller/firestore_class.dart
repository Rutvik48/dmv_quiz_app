import 'package:flutter/cupertino.dart';

import 'firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//This class holds methods to make changes and retrieve data from Firestore Cloud Database
class FireStoreClass {
  final firestoreInstance = Firestore.instance;
  static final FireStoreClass _singleton = FireStoreClass._internal();
  factory FireStoreClass() => _singleton;
  FireStoreClass._internal();

  static String selectedTopic = '';

  void setSelectedTopic(String topic) {
    selectedTopic = topic;
  }

  Future<Map> getQuestion({@required String subCollectionName}) async {
    print("Get Data is Called");
    QuerySnapshot questions;
    questions = await firestoreInstance
        .collection(FIREBASE_MAIN_QUIZ_COLLECTION)
        .document(FIREBASE_MAIN_QUIZ_DOCUMENT)
        ///TODO: Change this collection string to user selected topic
        .collection(selectedTopic)
        .getDocuments();

    print(questions);

    return changeIntoMap(questions);
  }

  Map changeIntoMap(QuerySnapshot querySnapshot) {
    Map questionBank = new Map<int, Map<String, dynamic>>();

    int counter = 0;
    for (var document in querySnapshot.documents) {
      if (document[FIREBASE_FIELD_QUESTION] != null) {
        questionBank.putIfAbsent(counter, () => document.data);
        counter++;
      }
    }

//    questionBank.forEach((key, value) {
//      print("Key: $key\n\n");
//
//      print("Value $value\n\n");
//    });

    return questionBank;
  }

  // Future<Map> getTopics() async {
  //
  //   DocumentSnapshot documents;
  //   documents = await firestoreInstance
  //       .collection(FIREBASE_MAIN_QUIZ_COLLECTION)
  //       .document(FIREBASE_MAIN_QUIZ_DOCUMENT)
  //       .get();
  //
  //   return changeTopicsIntoMap(documentSnapshot: documents, topicString: 'topics');
  // }
  //
  // Map changeTopicsIntoMap({@required DocumentSnapshot documentSnapshot, @required String topicString}) {
  //   Map topicMap = new Map<String, String>();
  //
  //   int counter = 0;
  //   documentSnapshot.data[topicString].forEach((key, value) {
  //     topicMap[key] = value;
  //   });
  //
  //   print(topicMap);
  //
  //   return topicMap;
  // }


  Future<Map> getTopics() async {

    DocumentSnapshot documents;
    documents = await firestoreInstance
        .collection(FIREBASE_MAIN_QUIZ_COLLECTION)
        .document(FIREBASE_MAIN_QUIZ_DOCUMENT)
        .get();

    return changeTopicsIntoMap(documentSnapshot: documents, topicString: FIREBASE_QUIZ_MAIN_TOPIC_ARRAY);
  }

  Future<Map> getSubTopics(String selectedMainTopic) async {

    DocumentSnapshot documents;
    print ('Selected Main Topic in getSubTopics $selectedMainTopic');
    print ('Selected Topic in getSubTopics $selectedTopic');
    documents = await firestoreInstance
        .collection(FIREBASE_MAIN_QUIZ_COLLECTION)
        .document(FIREBASE_MAIN_QUIZ_DOCUMENT)
        .collection(selectedTopic)
        .document(FIREBASE_QUIZ_SUB_TOPICS_DOCUMENT)
        .get();

    // var test = await firestoreInstance.collection(FIREBASE_MAIN_QUIZ_COLLECTION).document(FIREBASE_MAIN_QUIZ_DOCUMENT).collection(selectedTopic).getDocuments();
    // print(test);
    //
    // var test2 = await firestoreInstance
    //     .collection(FIREBASE_MAIN_QUIZ_COLLECTION)
    //     .document(FIREBASE_MAIN_QUIZ_DOCUMENT)
    //     .collection(selectedTopic)
    //     .document(FIREBASE_QUIZ_SUB_TOPICS_DOCUMENT)
    //     .get();
    // print(test2);

    // documents = await firestoreInstance.collection('question_main_collection/new_york/1').document('sub-topics').get().whenComplete((){
    //   print(documents);
    //   return changeTopicsIntoMap(documentSnapshot: documents, topicString: FIREBASE_QUIZ_SUB_TOPICS_DOCUMENT);
    // });

    return changeSubTopicsIntoMap(documentSnapshot: documents);
    print(documents);
  }


  Map createMap({@required DocumentSnapshot documentSnapshot, @required String topicString, trueForTopic=false}) {
    Map topicMap = new Map<String, String>();

    print(documentSnapshot.data);
    int counter = 0;
    if (trueForTopic){
      documentSnapshot.data[topicString].forEach((key, value) {
        topicMap[key] = value;
      });
    } else {
      documentSnapshot.data.forEach((key, value) {
        topicMap[key] = value;
      });
    }
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
    @required String lastName,
    String userPicture
  }){

    firestoreInstance.collection(FIREBASE_MAIN_USER_COLLECTION).
    document(FIREBASE_MAIN_USER_DOCUMENT).
    collection(userEmail).
    document(FIREBASE_USER_DETAIL_DOCUMENT).setData(
      {
        FIREBASE_USER_DETAIL_FIELD_FIRST_NAME: firstName,
        FIREBASE_USER_DETAIL_FIELD_LAST_NAME: lastName,
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


  void addData() {
    final firestoreInstance = Firestore.instance;
    print("Add Data is called!!");
    firestoreInstance.collection(FIREBASE_MAIN_QUIZ_COLLECTION).add({
      "name": "john",
      "age": 50,
      "email": "example@example.com",
      "address": {"street": "street 24", "city": "new york"}
    }).then((value) {
      print(value.documentID);
    });
  }
}
