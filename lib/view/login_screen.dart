import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/controller/quiz_screen_custom_widgets.dart';
import 'package:dmvquizapp/view/bottomNavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/controller/sign_in_class.dart';
import 'package:dmvquizapp/controller/firebase_auth_class.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuthClass firebaseAuthInstance = FirebaseAuthClass();
  static const double padding = 30.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: kCustomText(text: 'Sign In Here'),
        backgroundColor: kLogoMatchingColor,
      ),
      body: buildLogInScreen(),
      backgroundColor: Color(0xFF6CA8F1),
    );
  }

  Widget buildLogInScreen() {
    return Container(
      //color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //FlutterLogo(size: 150),
            //_getSignInHeader(),
            getEmailPswdTextFields(),
            getLoginButton(),
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
                    color: Colors.white,
                      text: "Don't have an Account?", minFontSize: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: kCustomText(
                      text: " Sign up",
                      color: Colors.white,
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

  Expanded getLoginButton() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLoginBtn(),
            kCustomText(
              text: '- OR -'
            ),
            Center(child: _signInButton()),
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
            _buildEmailTF(),
            SizedBox(
              height: 30.0,
            ),
            _buildPasswordTF(),
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

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        firebaseAuthInstance.signInWithGoogle().whenComplete(() {
          print('Sign in complete!');
        }).catchError((error, stackTrace) {
          print("inner: $error");
          // although `throw SecondError()` has the same effect.
          Navigator.pushNamed(context, AppBottomNavigationBar.idToTopicScreen);
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.white),
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
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _buildEmailTF() {
    return _buildTextBox(
      textBoxName: 'Email',
      icon: LineAwesomeIcons.envelope,
    );

  }

  Widget _buildPasswordTF() {
    return _buildTextBox(
      textBoxName: 'Password',
      icon: LineAwesomeIcons.lock,
    );
  }

  Widget _buildTextBox({
  @required String textBoxName,
    @required IconData icon,
}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        kCustomText(
          text: textBoxName,
          fontWeight: FontWeight.w900,
          color: Colors.white
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                icon,
                color: Colors.white,
              ),
              hintText: 'Enter your $textBoxName',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
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
            color: Colors.white
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
        backgroundColor: Colors.white,
          textColor: Color(0xFF527DAA),
      ),
    );
  }

}
