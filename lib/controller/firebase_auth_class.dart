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
  final GoogleSignIn googleSignIn = GoogleSignIn();

  static String _userFirstName;
  static String _userLastName;
  static String _userEmail;
  static String _userPicture;
  static bool _userLoginStatus;


  
  ///Getters
  String getFirstName(){
    return _userFirstName != null ? _userFirstName : '';
  }

  String getLastName(){
    return _userLastName != null ? _userLastName : '';
  }
  String getUserEmail() {

    //await _setUserInformation();
    return _userEmail != null ? _userEmail : '';
  }

  String getUserPicture(){
    return _userPicture != null ? _userPicture : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
  }

  bool getUserLoggedInStatus() {

    //return _userLoginStatus == null ? _setUserInformation() : _userLoginStatus;

    return _userLoginStatus;

    //return _userLoginStatus;
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
      final FirebaseUser currentUser = await _auth.currentUser();

      //currentuser would be null if user is not logged in.
      if (currentUser != null){

        if (currentUser.displayName != null){
          List<String> temp = currentUser.displayName.split(' ');
          if (temp.length > 1){
            _userFirstName =  temp[0];
            _userLastName = temp[1];
          } else{
            _userFirstName =  temp[0];
          }
        }

        _userEmail = currentUser.email;
        _userPicture = currentUser.photoUrl;
        _userLoginStatus = true;

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

    print('End of _getUserInformation()');
  }


  
  //Method used to sign in to Firebase Auth using sign in with google 
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
          String userName = '';

          var user = await FirebaseAuth.instance.currentUser();

          UserUpdateInfo updateUser = UserUpdateInfo();
          updateUser.displayName = fullName;
          user.updateProfile(updateUser);

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
  Future<void> signOutGoogle() async{
    await googleSignIn.signOut();

    await _auth.signOut();

    _userLoginStatus=false;
  }


  //Method checks error given by Firebase Auth methods and shows appropriate alerts
  void showError({
    @required String errorCode,
    @required BuildContext context}){
    switch (errorCode) {
      case "ERROR_INVALID_EMAIL":{
        print('Check your Email');
        kShowAlert(context: context, alertTitle: 'Invalid Email', alertText: "Check your email.");
      }
      break;

      case "ERROR_USER_NOT_FOUND":{
        print('User is not registered. Please check your email');
        kShowAlert(context: context, alertTitle: 'Email Not Found', alertText: "Email is not found.");
      }
      break;

      case ("ERROR_WRONG_PASSWORD"):{
        print('Password is wrong');
        kShowAlert(context: context, alertTitle: 'Check Details', alertText: "Email or Password is wrong");
      }
      break;

      case ("ERROR_WRONG_PASSWORD"):{print('');}
      break;

      case ("ERROR_NETWORK_REQUEST_FAILED"):{
        print("There is an Network Issue. Ensure you're connected to Internet");
        kShowAlert(context: context, alertTitle: 'Network Issue', alertText: "Check you're connected to Internet and try again.");
      }
      break;

      case ("ERROR_WEAK_PASSWORD"):{
        print("There is an Network Issue. Ensure you're connected to Internet");
        kShowAlert(context: context, alertTitle: 'Weak Password', alertText: "Password length must be six letters at least.");
      }
      break;

      default:{
        print("Some issue occurred while logging in.");
        kShowAlert(context: context, alertTitle: "Can't Log In", alertText: "An Issue occurred while logging in. Please try again. \n$errorCode ");
      }
      break;
      //case
      //default:
    }
  }
  // void showError (error: Error?,errorMsg: AuthErrorCode,screen: UIViewController) {
  //
  // switch errorMsg {
  //
  // case .networkError:
  // createUIalert("Network Error.", screen)
  // break
  // case .userNotFound:
  // createUIalert("Email Not Found!", screen)
  // break
  // case .wrongPassword:
  // createUIalert("Email or Pasword is wrong", screen)
  // break
  // case .tooManyRequests:
  // createUIalert("too many request", screen)
  // break
  // case .invalidEmail:
  // createUIalert("Invalid Email", screen)
  // break
  // case .emailAlreadyInUse:
  // createUIalert("Email is already in use.", screen)
  // break
  // case .weakPassword:
  // createUIalert("weak password", screen)
  // break
  // default:
  // createUIalert("Error occured. Please try again.", screen)
  // }
  // }

}