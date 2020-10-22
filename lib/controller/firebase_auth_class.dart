import 'package:flutter/cupertino.dart';
import 'firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthClass{

  final _auth = FirebaseAuth.instance;
  FirebaseAuthClass._internal();
  static final FirebaseAuthClass _singleton = FirebaseAuthClass._internal();
  factory FirebaseAuthClass() => _singleton;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  static String userFirstName;
  static String userLastName;
  static String userEmail;
  static String userPicture;


  void fillUserInformation() async {
    await _getUserInformation();
  }

  String getFirstName(){
    return userFirstName != null ? userFirstName : 'User Name';
  }

  String getLastName(){
    return userLastName != null ? userLastName : 'User Name';
  }
  Future<String> getUserEmail() async {
    print('\n\nInside getUserEmail()\n\n');
    //getUserEmailFromFirebaseAuth();
    await _getUserInformation();
    print('After calling getUserEmailFromFirebaseAuth() $userEmail');
    return userEmail;
  }
  // void getUserEmailFromFirebaseAuth() async{
  //
  //   print('\n\nInside getUserEmailFromFirebaseAuth()\n\n');
  //   if (userEmail == null) {
  //     //await _getUserInformation();
  //   }
  //   print('\n\nDone getUserEmailFromFirebaseAuth()\n\n');
  //
  //   //return userEmail != null ? userEmail : "User's Email";
  // }

  String getUserPicture(){
    return userPicture != null ? userPicture : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
  }

  Future<void> _getUserInformation() async{
    print('_getUserInformation() is called');
    FirebaseUser currentUser;// = await _auth.currentUser();
    await _auth.currentUser();

    currentUser = await _auth.currentUser();
    //currentuser would be null if user is not logged in.
    if (currentUser != null){

      var temp = currentUser.displayName.split(' ');
      userFirstName =  temp[0];
      userLastName = temp[1];
      userEmail = currentUser.email;
      userPicture = currentUser.photoUrl;

      //return userFirstName;
    } else {
      print('User is not logged in or _auth.currentUser is null');
      //return null;
    }

    print('End of _getUserInformation()');
  }


  Future<String> signInWithGoogle() async {

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }


  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }

}