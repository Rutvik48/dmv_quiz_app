import 'package:firebase_storage/firebase_storage.dart';
import 'package:dmvquizapp/controller/firebase_auth_class.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageClass{
  FirebaseStorage firebaseStorageClass = FirebaseStorage.instanceFor(bucket: "gs://ny-dmv-quiz-app.appspot.com");
  FirebaseAuthClass firebaseAuthInstance = FirebaseAuthClass();

  Future<String > uploadFile(var file) async {
    //var
    String fileURL = '';
    String userID = firebaseAuthInstance.getUserID();
    var storageRef = firebaseStorageClass.ref().child('user/profile/$userID');
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.then((value) async {
      print('Inside then. Value is: ${value}');
      if (value != null){
        print('Upload to Firebase Storage is successful');
        //print("Here is URL: ${value.ref.getDownloadURL()}");
        fileURL = await value.ref.getDownloadURL();
      }else {
        print('Upload to Firebase Storage Failed. Here is the value: ${value}');
      }
    });

    //fileURL = uploadTask.
    return fileURL;

  }
}

