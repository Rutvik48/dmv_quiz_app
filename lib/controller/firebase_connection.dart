import 'package:flutter/cupertino.dart';

import 'firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore_Class {
  final firestoreInstance = Firestore.instance;

  Future<Map> getQuestion({@required String subCollectionName}) async {
    print("Get Data is Called");
    QuerySnapshot questions;
    questions = await firestoreInstance
        .collection(FIREBASE_NY_TRAFFIC_CONTROL_SUB_COLLECTION)
        .getDocuments();

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

  Future<DocumentSnapshot> getTopics() async {
    print("Get Data is Called");
    var documents;
    documents = await firestoreInstance
        .collection(FIREBASE_MAIN_COLLECTION)
        .document('ny')
        .get();

    print('Going into for loop');
    print(documents['topic']);
    for (var doc in documents['topic']) {
      print("THIS IS DOC: $doc");
    }
    return documents;
  }

  void addData() {
    final firestoreInstance = Firestore.instance;
    print("Add Data is called!!");
    firestoreInstance.collection(FIREBASE_MAIN_COLLECTION).add({
      "name": "john",
      "age": 50,
      "email": "example@example.com",
      "address": {"street": "street 24", "city": "new york"}
    }).then((value) {
      print(value.documentID);
    });
  }
}
