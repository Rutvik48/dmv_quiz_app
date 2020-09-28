import 'package:flutter/cupertino.dart';

import 'firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreClass {
  final firestoreInstance = Firestore.instance;

  static final FireStoreClass _singleton = FireStoreClass._internal();
  static String selectedTopic = 'traffic_controll';

  factory FireStoreClass() => _singleton;
  FireStoreClass._internal();


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
    print (selectedMainTopic);
    // documents = await firestoreInstance
    //     .collection(FIREBASE_MAIN_QUIZ_COLLECTION)
    //     .document(FIREBASE_MAIN_QUIZ_DOCUMENT)
    //     .collection(selectedMainTopic)
    //     .document(FIREBASE_QUIZ_SUB_TOPICS_DOCUMENT)
    //     .get();

    documents = await firestoreInstance.collection('question_main_collection/new_york/1').document('sub-topics').get();

    return changeTopicsIntoMap(documentSnapshot: documents, topicString: FIREBASE_QUIZ_SUB_TOPICS_DOCUMENT);
  }

  Map changeTopicsIntoMap({@required DocumentSnapshot documentSnapshot, @required String topicString}) {
    Map topicMap = new Map<String, String>();

    print(documentSnapshot.data);
    int counter = 0;
    documentSnapshot.data[topicString].forEach((key, value) {
      topicMap[key] = value;
    });

    print(topicMap);

    return topicMap;
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
