import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/view/login_screen.dart';
//import 'package:dmvquizapp/controller/quiz_screen_custom_widgets.dart';
//import 'package:dmvquizapp/view/bottomNavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
//import 'package:dmvquizapp/controller/sign_in_class.dart';
import 'package:dmvquizapp/controller/firebase_auth_class.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signUp_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuthClass firebaseAuthInstance = FirebaseAuthClass();
  static const double padding = 30.0;
  static const textColor = Colors.white;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //Removes keyboard when clicked outside of a text field
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        //Makes screen fixed when keyboard comes up
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: kCustomText(text: 'Sign Up Here'),
          backgroundColor: kLogoMatchingColor,
        ),
        body: buildSignUpScreen(),
        backgroundColor: Color(0xFF60A6F1),
      ),
    );
  }

  Widget buildSignUpScreen() {
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

            //getSignUpText(),
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
                      text: "Already have an Account?", minFontSize: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: kCustomText(
                      text: " Sign In Here",
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
      flex: 3,
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
      flex: 3,
      child: Container(
        //color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.only(right: padding, left: padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildFullNameTextField(),
              SizedBox(
                height: 15.0,
              ),
              buildEmailTextField(),
              SizedBox(
                height: 15.0,
              ),
              buildPasswordTextField(),
              _getForgetPasswordText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInWithGoogleButton() {

    return getSignUpLogInWithGoogleButton(
      textColor: textColor,
      context: context,
      signInOrUpText: 'Sign Up',

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
        buttonText: 'Sign Up',
        backgroundColor: textColor,
        textColor: Color(0xFF527DAA),
      ),
    );
  }

}
