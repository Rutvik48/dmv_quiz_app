import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dmvquizapp/controller/quiz_screen_custom_widgets.dart';

class FirebaseAuthClass{

  final _auth = FirebaseAuth.instance;
  FirebaseAuthClass._internal();
  static final FirebaseAuthClass _singleton = FirebaseAuthClass._internal();
  factory FirebaseAuthClass() => _singleton;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  static String _userFullName;
  static String _userEmail;
  static String _userPicture;
  static bool _userLoginStatus = false;
  static String _userID = '';


  
  ///Getters

  String getUserID(){
    return _userID;
  }

  String getFirstName(){
    return _userFullName != null ? _userFullName : '';
  }

  String getUserEmail() {

    //await _setUserInformation();
    return _userEmail != null ? _userEmail : '';
  }

  String getUserPicture(){
    return _userPicture != null ? _userPicture : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
  }

  bool getUserLoggedInStatus() {
    return _userLoginStatus;

}

  
  ///Setters
  Future<bool> fillUserInformation() async {
    return await _setUserInformation();
  }
   
   //Sets user information such as _userLoginStatus, name, email, picture.
  Future<bool> _setUserInformation() async{

    //First checking if  the setting user info is required.
    //if function is called earlier, then useremail won't be ''(empty)
    if (getUserEmail() == ''){
      final User currentUser = await _auth.currentUser;

      //currentuser would be null if user is not logged in.
      if (currentUser != null){

        if (currentUser.displayName != null){
          _userFullName = currentUser.displayName;
        }
        _userEmail = currentUser.email;
        _userPicture = currentUser.photoURL;
        _userLoginStatus = true;
        _userID = currentUser.uid;

        return true;
        //return userFirstName;
      } else {
        print('User is not logged in or _auth.currentUser is null');
        //return null;
        return false;
      }
    }else {
      return true;
    }

    //print('End of _getUserInformation()');
  }


  
  //Method used to sign in to Firebase Auth using sign in with google 
  Future<String> signInWithGoogle() async {

    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  //Method to create a new user with email and password 
  Future<String> createNewUserWithEmail ({
    @required String userEmail,
    @required String userPassword,
    @required String fullName,
  }) async {

    String returnValue = 'null';

    try{
      await _auth.createUserWithEmailAndPassword(email: userEmail, password: userPassword)
          .catchError((error){

        returnValue = error.code;
      }).then((value) async {
        print('This is then inside signUpNewUserWithEmail() Value: $value');

        if (value != null){

          setUserName(fullName);
          // var user = await FirebaseAuth.instance.currentUser();
          //
          // UserUpdateInfo updateUser = UserUpdateInfo();
          // updateUser.displayName = fullName;
          // user.updateProfile(updateUser);

          //firebase.auth().currentUser
        }
      }).whenComplete(() {
        print('This is whenCompleted inside signUpNewUserWithEmail().');
      });
    }catch (error){
      print('Error caught in signUpNewUserWithEmail()');
    }

    return returnValue;
  }

  Future<bool> setUserName (String userName) async {

    try {
      var user = FirebaseAuth.instance.currentUser;


      User updateUser = User as User;
      updateUser.updateProfile(displayName: userName);
      user.updateProfile();
      print("Username changed to : $userName");
      return true;
    } catch (error){
      return false;
    }
  }

  Future<bool> setUserImage (String userImageUrl) async {

    try {
      var user = FirebaseAuth.instance.currentUser;

      User updateUser = User as User;
      updateUser.updateProfile(photoURL: userImageUrl);
      user.updateProfile();
      print("URL changed to : $userImageUrl");
      return true;
    } catch (error){
      return false;
    }
  }
  
  //Sign in method
   Future<String> signInWithEmail({
      @required String userEmail,
      @required String userPassword
      })
  async {

    String returnValue = 'null';
    try {
      await _auth
          .signInWithEmailAndPassword(email: userEmail, password: userPassword)
          .catchError((error) {

            print('This is catcherror: ----> $error');
        returnValue = error.code;
      }).then((value) {
        print("This is value:-----> ${value} ");
        if (value != null){
          _setUserInformation();
        }
      });
    } catch (error){
      //throw error.code;
      print("This is ---> $error");
    }
    return returnValue;
  }


  //sign out method to sign out from googleSignIn and firebase auth
  Future<void> signOutUser() async{
    await _googleSignIn.signOut();

    await _auth.signOut();

    _resetUserInfo();
  }


  void _resetUserInfo() {
    
    _userEmail='';
    _userFullName = '';
    _userPicture = '';
    _userID = '';
    _userLoginStatus = false;
  }


  //Method checks error given by Firebase Auth methods and shows appropriate alerts
  void showError({
    @required String errorCode,
    @required BuildContext context}){
    switch (errorCode) {
      case "ERROR_INVALID_EMAIL":{
        print('Check your Email');
        kShowAlert(context: context, alertTitle: 'Invalid Email', alertText: "Check your email.", mainButtonOnTap: (){Navigator.of(context).pop();});
      }
      break;

      case "ERROR_USER_NOT_FOUND":{
        print('User is not registered. Please check your email');
        kShowAlert(context: context, alertTitle: 'Email Not Found', alertText: "Email is not found.", mainButtonOnTap: (){Navigator.of(context).pop();});
      }
      break;

      case ("ERROR_WRONG_PASSWORD"):{
        print('Password is wrong');
        kShowAlert(context: context, alertTitle: 'Check Details', alertText: "Email or Password is wrong", mainButtonOnTap: (){Navigator.of(context).pop();});
      }
      break;

      case ("ERROR_WRONG_PASSWORD"):{print('');}
      break;

      case ("ERROR_NETWORK_REQUEST_FAILED"):{
        print("There is an Network Issue. Ensure you're connected to Internet");
        kShowAlert(context: context, alertTitle: 'Network Issue', alertText: "Check you're connected to Internet and try again.", mainButtonOnTap: (){Navigator.of(context).pop();});
      }
      break;

      case ("ERROR_WEAK_PASSWORD"):{
        print("There is an Network Issue. Ensure you're connected to Internet");
        kShowAlert(context: context, alertTitle: 'Weak Password', alertText: "Password length must be six letters at least.", mainButtonOnTap: (){Navigator.of(context).pop();});
      }
      break;

      default:{
        print("Some issue occurred while logging in.");
        kShowAlert(context: context, alertTitle: "Can't Log In", alertText: "An Issue occurred while logging in. Please try again. \n$errorCode ", mainButtonOnTap: (){Navigator.of(context).pop();});
      }
      break;
      //case
      //default:
    }
  }
}