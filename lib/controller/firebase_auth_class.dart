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

  static String userName;
  static String userEmail;
  static String userPicture;


  void fillUserInformation() async {
    await _getUserInformation();
  }

  String getUserName(){
    return userName != null ? userName : 'User Name';
  }

  String getUserEmail(){
    return userEmail != null ? userEmail : "User's Email";
  }

  String getUserPicture(){
    return userPicture != null ? userPicture : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
  }

  Future<String> _getUserInformation() async{

    print('Get userinfo is called');

    final FirebaseUser currentUser = await _auth.currentUser();

    //currentuser would be null if user is not logged in.
    if (currentUser != null){

      userName = currentUser.displayName;
      userEmail = currentUser.email;
      userPicture = currentUser.photoUrl;

      return userName;
    } else {
      print('User is not logged in or _auth.currentUser is null');
      return null;
    }

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