import 'firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore_Class {


  final firestoreInstance = Firestore.instance;


  Future<QuerySnapshot> getQuestion() async {
    print("Get Data is Called");
    var documents;
    documents =  await firestoreInstance.collection(FIREBASE_NY_TRAFFIC_CONTROL_SUB_COLLECTION).getDocuments().then((value) {print(value.documents);});
    //.then((value) {print(value.data.runtimeType);});

    print('Going into for loop');
    print(documents);
    for (var doc in documents.data){
      print("THIS IS DOC: $doc");
    }
    return documents;
  }

  Future<DocumentSnapshot> getTopics() async {
    print("Get Data is Called");
    var documents;
    documents =  await firestoreInstance.collection(FIREBASE_MAIN_COLLECTION).document('ny').get();

    print('Going into for loop');
    print(documents['topic']);
    for (var doc in documents['topic']){
      print("THIS IS DOC: $doc");
    }
    return documents;
  }

  void addData () {
    final firestoreInstance = Firestore.instance;
    print("Add Data is called!!");
    firestoreInstance.collection(FIREBASE_MAIN_COLLECTION).add(
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