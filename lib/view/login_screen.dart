import 'package:dmvquizapp/view/bottomNavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/controller/sign_in_class.dart';
import 'package:dmvquizapp/controller/firebase_auth_class.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuthClass firebaseAuthInstance = FirebaseAuthClass();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: kCustomText(text: 'Log In Here'),),
      body: buildLogInScreen(),
    );
  }

  Widget buildLogInScreen(){
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(size: 150),
            SizedBox(height: 50),
            _signInButton(),
          ],
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        firebaseAuthInstance.signInWithGoogle().whenComplete(() {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return FirstScreen();
          //     },
          //   ),
          // );
          print('Sign in complete!');
        }).catchError((error, stackTrace) {
          print("inner: $error");
          // although `throw SecondError()` has the same effect.
          Navigator.pushNamed(context, AppBottomNavigationBar.idToTopicScreen);
        });
      },

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
