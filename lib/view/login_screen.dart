import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/controller/firestore_class.dart';
import 'package:dmvquizapp/controller/quiz_screen_custom_widgets.dart';
import 'package:dmvquizapp/view/bottomNavigationBar.dart';
import 'package:dmvquizapp/view/signup_screen.dart';
import 'package:dmvquizapp/view/welcom_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/controller/sign_in_class.dart';
import 'package:dmvquizapp/controller/firebase_auth_class.dart';
import 'package:dmvquizapp/controller/custom_methods_class.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuthClass firebaseAuthInstance = FirebaseAuthClass();
  TextEditingController emailTextHolder = TextEditingController();
  TextEditingController passwordTextHolder = TextEditingController();
  static const double padding = 30.0;
  static const textColor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final firestoreSingleton = FireStoreClass();

    //firestoreSingleton.addUser(userEmail: 'email@123.com', firstName: 'First Name', lastName: 'Last Name');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Removes keyboard when clicked outside of a text field
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: kCustomText(text: 'Sign In Here'),
          backgroundColor: kLogoMatchingColor,
        ),
        body: buildLogInScreen(),
        backgroundColor: Color(0xFF60A6F1),
      ),
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
                      text: "Don't have an Account?",
                      minFontSize: 20.0),
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
                minFontSize: 15.0),
            Center(child: _signInWithGoogleButton()),
          ],
        ),
      ),
    );
  }

  Expanded getEmailPswdTextFields() {
    return Expanded(
      flex: 4,
      child: Container(
        //color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildEmailTextField(emailTextHolder: emailTextHolder),
              SizedBox(
                height: 30.0,
              ),
              buildPasswordTextField(passwordTextHolder: passwordTextHolder),
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
      signInOrUpText: 'Sign In',
    );
  }

  Widget _getForgetPasswordText() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      //TODO: Implement onTap, or move it to custom_widget.dart
      child: GestureDetector(
        child: Align(
          alignment: Alignment.bottomRight,
          child: kCustomText(
              text: 'Forgot Password?',
              fontWeight: FontWeight.w900,
              color: textColor),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      width: double.infinity,
      child: kRoundButton(
        onPressed: () async {
          String email;
          String password;

          try {
            email = filterText(emailTextHolder.text);
            password = passwordTextHolder.text;

            String status = await firebaseAuthInstance.signInWithEmail(
                userEmail: email, userPassword: password);

            if (status != 'null') {
              firebaseAuthInstance.showError(errorCode: status, context: context);
            } else {
              Navigator.pushNamed(context, AppBottomNavigationBar.idToHomeScreen);
              print("Login Successful.");
            }

            print(
                'Getting User"s email: ${await firebaseAuthInstance.getUserEmail()}');
            print('Email: ${emailTextHolder.text}');
            print('Password: ${passwordTextHolder.text}');
          } catch (error) {
            kShowToast(toastMessage: 'Fill all shown fields');
            print('Error caught in buildLogInBtn');
            print(error);
          } finally {}
        },
        buttonText: 'LOGIN',
        backgroundColor: textColor,
        textColor: Color(0xFF527DAA),
      ),
    );
  }
}
