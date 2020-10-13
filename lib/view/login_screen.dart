import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/controller/quiz_screen_custom_widgets.dart';
import 'package:dmvquizapp/view/bottomNavigationBar.dart';
import 'package:dmvquizapp/view/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/controller/sign_in_class.dart';
import 'package:dmvquizapp/controller/firebase_auth_class.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuthClass firebaseAuthInstance = FirebaseAuthClass();
  static const double padding = 30.0;
  static const textColor = Colors.white;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: kCustomText(text: 'Sign In Here'),
        backgroundColor: kLogoMatchingColor,
      ),
      body: buildLogInScreen(),
      backgroundColor: Color(0xFF60A6F1),
    );
  }

  Widget buildLogInScreen() {
    return Container(
      //color: textColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //FlutterLogo(size: 150),
            //_getSignInHeader(),
            getEmailPswdTextFields(),
            
            _getLoginAndGoogleSignUpButton(),

            getSignUpText(),
            //SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Expanded getSignUpText() {
    return Expanded(
      child: Container(
        //color: Colors.blueGrey,
        child: Stack(
          children: [
            Positioned(
              bottom: 30.0,
              right: 0.0,
              left: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kCustomText(
                    color: textColor,
                      text: "Don't have an Account?", minFontSize: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: kCustomText(
                      text: " Sign up",
                      color: textColor,
                      minFontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _getLoginAndGoogleSignUpButton() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLoginBtn(),
            kCustomText(
              text: '--- OR ---',
              color: textColor,
              fontWeight: FontWeight.bold,
              minFontSize: 20.0
            ),
            Center(child: _signInWithGoogleButton()),
          ],
        ),
      ),
    );
  }




  Expanded getEmailPswdTextFields() {
    return Expanded(
      flex: 2,
      child: Container(
        //color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildEmailTextField(),
            SizedBox(
              height: 30.0,
            ),
            buildPasswordTextField(),
            _getForgetPasswordText(),
          ],
      ),
        ),
      ),
    );
  }

  Expanded _getSignInHeader() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.red,
      ),
    );
  }

  Widget _signInWithGoogleButton() {
    
    return getSignUpLogInWithGoogleButton(
      textColor: textColor,
      context: context,
      signInOrUpText: 'Sign In',

    );
  }

  Widget _getForgetPasswordText(){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        child: Align(
          alignment: Alignment.bottomRight,
          child: kCustomText(
            text: 'Forgot Password?',
            fontWeight: FontWeight.w900,
            color: textColor
          ),
        ),
      ),
    );
  }


  Widget _buildLoginBtn() {
    return Container(
      width: double.infinity,
      child: kRoundButton(
          onPressed: (){},
          buttonText: 'LOGIN',
        backgroundColor: textColor,
          textColor: Color(0xFF527DAA),
      ),
    );
  }

}