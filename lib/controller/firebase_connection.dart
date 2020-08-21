import 'firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore_Class {


  final firestoreInstance = Firestore.instance;

  void addData () {
    final firestoreInstance = Firestore.instance;
    print("Add Data is called!!");
    firestoreInstance.collection(FIREBASE_QUIZ_COLLECTION).add(
        {
          "name" : "john",
          "age" : 50,
          "email" : "example@example.com",
          "address" : {
            "street" : "street 24",
            "city" : "new york"
          }
        }).then((value){
      print(value.documentID);
    });
  }
}