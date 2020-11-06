import 'package:dmvquizapp/controller/firebase_auth_class.dart';
import 'package:dmvquizapp/view/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/controller/firestore_class.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _State createState() => _State();
}

class _State extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  static final firestoreSingleton = FireStoreClass();
  static final firebaseAuthInstance = FirebaseAuthClass();
  bool userLoggedInState = false;

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();


    initialWork();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = ColorTween(begin: kLogoMatchingColor, end: kLogoBackgroundColor)
        .animate(controller);
    //animation = ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });

    //initialWork();
  }

  void initialWork() async{
    //await firebaseAuthInstance.signOutGoogle();
     userLoggedInState = await firebaseAuthInstance.fillUserInformation();

     userLoggedInState ? print('User is logged in') : print('User not logged in');
     setState(() {});

     //var user = firebaseAuthInstance.getFirstName();
    //userLoggedInState ? kShowToast(toastMessage: 'Hello $user'):null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //Expended widget takes as much space as possible
            Expanded(
              child: Image.asset(kWelcomeScreenLogoPath),
              flex: 3,
            ),

            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: TypewriterAnimatedTextKit(
                  text: [kQuizAppName],
                  speed: Duration(milliseconds: 200),
                  textAlign: TextAlign.center,
                  isRepeatingAnimation: false,
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: kLogoMatchingColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: kCustomText(
                  text: kQuizDescription,
                  color: kLogoMatchingColor,
                  maxFontSize: 18,
                ),
              ),
            ),

            if (!userLoggedInState) Expanded(
              child: Center(
                child: Container(
                  //color: Colors.yellow,
                  child: kRoundButton(
                    buttonText: 'Log In / Sign Up Here',
                    fontWeight: FontWeight.normal,
                    textColor: kLogoMatchingColor,
                    backgroundColor: kLogoBackgroundColor,
                    onPressed: (){
                      Navigator.pushNamed(context, LoginScreen.id);
                    },),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
