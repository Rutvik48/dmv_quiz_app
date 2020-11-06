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

  static String userFirstName;
  static String userLastName;
  static String userEmail;
  static String userPicture;


  Future<bool> fillUserInformation() async {
    return await _setUserInformation();
  }

  String getFirstName(){
    return userFirstName != null ? userFirstName : '';
  }

  String getLastName(){
    return userLastName != null ? userLastName : '';
  }
  Future<String> getUserEmail() async {

    await _setUserInformation();

    return userEmail;
  }

  String getUserPicture(){
    return userPicture != null ? userPicture : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
  }

  Future<bool> _setUserInformation() async{

    final FirebaseUser currentUser = await _auth.currentUser();

    //currentuser would be null if user is not logged in.
    if (currentUser != null){

      if (currentUser.displayName != null){
        List<String> temp = currentUser.displayName.split(' ');
        if (temp.length > 1){
          userFirstName =  temp[0];
          userLastName = temp[1];
        } else{
          userFirstName =  temp[0];
        }
      }

      userEmail = currentUser.email;
      userPicture = currentUser.photoUrl;

      return true;
      //return userFirstName;
    } else {
      print('User is not logged in or _auth.currentUser is null');
      //return null;
      return false;
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

  Future<String> signUpNewUserWithEmail ({
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

        returnValue = error.code;
      });
    } catch (error){
      //throw error.code;
      print("This is ---> $error");
    }

    return returnValue;
  }

  Future<void> signOutGoogle() async{
    await googleSignIn.signOut();
    print("Google User Sign Out");

    await _auth.signOut();
    print("Firebase User Sign Out");

  }


  void showError({
    @required String errorCode,
    @required BuildContext context}){
    switch (errorCode) {
      case "ERROR_INVALID_EMAIL":{
        print('Check your Email');
        showAlert(context: context, alertTitle: 'Invalid Email', alertText: "Check your email.");
      }
      break;

      case "ERROR_USER_NOT_FOUND":{
        print('User is not registered. Please check your email');
        showAlert(context: context, alertTitle: 'Email Not Found', alertText: "Email is not found.");
      }
      break;

      case ("ERROR_WRONG_PASSWORD"):{
        print('Password is wrong');
        showAlert(context: context, alertTitle: 'Check Details', alertText: "Email or Password is wrong");
      }
      break;

      case ("ERROR_WRONG_PASSWORD"):{print('');}
      break;

      case ("ERROR_NETWORK_REQUEST_FAILED"):{
        print("There is an Network Issue. Ensure you're connected to Internet");
        showAlert(context: context, alertTitle: 'Network Issue', alertText: "Check you're connected to Internet and try again.");
      }
      break;

      case ("ERROR_WEAK_PASSWORD"):{
        print("There is an Network Issue. Ensure you're connected to Internet");
        showAlert(context: context, alertTitle: 'Weak Password', alertText: "Password length must be six letters at least.");
      }
      break;

      default:{
        print("Some issue occurred while logging in.");
        showAlert(context: context, alertTitle: "Can't Log In", alertText: "An Issue occurred while logging in. Please try again. \n$errorCode ");
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