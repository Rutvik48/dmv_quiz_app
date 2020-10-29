import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/controller/firebase_auth_class.dart';
import 'package:dmvquizapp/controller/firestore_class.dart';
import 'package:dmvquizapp/view/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:dmvquizapp/controller/sign_in_class.dart';

FirebaseAuthClass firebaseAuthInstance = FirebaseAuthClass();
final firestoreSingleton = FireStoreClass();

Widget kCustomText({
  String text,
  Color color,
  TextAlign textAlign = TextAlign.center,
  fontWeight = FontWeight.normal,
  double maxFontSize = kDefaultMaxFontSize,
  double minFontSize = kDefaultMinFontSize,
}) {
  return AutoSizeText(
    text,
    //overflow: TextOverflow.ellipsis,
    maxLines: 5,
    textAlign: textAlign,
    minFontSize: minFontSize,
    maxFontSize: maxFontSize,
    softWrap: true,
    wrapWords: true,
    overflow: TextOverflow.visible,
    style: GoogleFonts.lato().copyWith(
      color: color,
      fontWeight: fontWeight,
    ),
  );
}

Padding kOptionButton(
    {double fontSize = kOptionsMinFontSize,
    @required String text,
    @required Function onPressed,
    double borderWidth = 5,
    Color borderColor = kOptionBorderColor}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: kQuizScreenLeftRightPadding,
      right: kQuizScreenLeftRightPadding,
      top: 5.0,
      bottom: 5.0,
    ),
    child: _kCustomRaisedButton(
        onPressed: onPressed,
        text: text,
        fontSize: fontSize,
        borderColor: borderColor,
        borderWidth: borderWidth),
  );
}

RaisedButton _kCustomRaisedButton(
    {double fontSize = kOptionsMinFontSize,
    @required String text,
    @required Function onPressed,
    double borderWidth = 5,
    Color borderColor = kOptionBorderColor}) {
  return RaisedButton(
    onPressed: onPressed,
    child: kCustomText(
        text: text,
        maxFontSize: kOptionsMaxFontSize,
        minFontSize: fontSize,
        fontWeight: FontWeight.bold),
    color: kOptionButtonBackgroundColor,
    //textColor: kLogoMatchingColor,
    elevation: 8,
    //Creates circular edge on the top left corner of the Start button
    shape: new RoundedRectangleBorder(
      side: BorderSide(
          color: borderColor, width: borderWidth, style: BorderStyle.solid),
      borderRadius: new BorderRadius.all(Radius.circular(kButtonRadius)),
    ),
  );
}

CircularCountDownTimer kCircularCountDownTimer() {
  return CircularCountDownTimer(
    // Countdown duration in Seconds
    duration: 60,
    // Width of the Countdown Widget
    width: 100,
    // Height of the Countdown Widget
    height: 70,
    // Default Color for Countdown Timer
    color: Colors.white,
    // Filling Color for Countdown Timer
    fillColor: kLogoMatchingColor,
    // Border Thickness of the Countdown Circle
    strokeWidth: 5.0,
    // Text Style for Countdown Text
    textStyle: TextStyle(
        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.bold),
    // true for reverse countdown (max to 0), false for forward countdown (0 to max)
    isReverse: false,
    // Optional [bool] to hide the [Text] in this widget.
    isTimerTextShown: true,
    // Function which will execute when the Countdown Ends
    onComplete: () {
      // Here, do whatever you want
      print('Countdown Ended');
    },
  );
}

Padding kDash(BuildContext context) {
  return Padding(
    padding:const EdgeInsets.only(
      top: 25.0,
      bottom: 15.0,
    ),
    child: Center(
      child: const Divider(
        color: kLogoMatchingColor,
        //height: 20,
        thickness: 5,
        indent: 20,
        endIndent: 20,
      ),
    ),
  );
}


Future<bool> kShowToast({@required String toastMessage}){
  return Fluttertoast.showToast(
    msg: toastMessage,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.grey,
    textColor: Colors.white70,
    fontSize: 24.0,
  );
}

RaisedButton kRoundButton( {
  @required Function onPressed,
  @required String buttonText,
  double borderRadius=20,
  Color textColor=kLogoBackgroundColor,
  Color backgroundColor=kLogoMatchingColor,
  FontWeight fontWeight=FontWeight.w900,
  double topAndBottomPadding=10,

}) {
  return RaisedButton(
    visualDensity: VisualDensity.comfortable,
    onPressed: onPressed,
    child: Padding(
      padding: EdgeInsets.only(left: 35, right: 35, top: topAndBottomPadding, bottom: topAndBottomPadding),
      child: kCustomText(
        text: buttonText,
        minFontSize: kNextButtonFontSize,
        fontWeight: fontWeight,
        //color: kNextButtonTextColor,
        color: textColor,
      ),
    ),
    color: backgroundColor,
    textColor: kLogoMatchingColor,
    elevation: 8,
    //Creates circular edge on the top left corner of the Start button
    shape: RoundedRectangleBorder(
      borderRadius:
      new BorderRadius.all(Radius.circular(borderRadius)),
    ),
  );
}

RaisedButton kNextButton( {@required Function onPressed}) {
  return RaisedButton(
    onPressed: onPressed,
    child: Padding(
      padding: EdgeInsets.only(left: 35, right: 35, top: 25, bottom: 25),
      child: kCustomText(
        text: 'Next',
        minFontSize: kNextButtonFontSize,
        fontWeight: FontWeight.w900,
        //color: kNextButtonTextColor,
        color: kLogoBackgroundColor,
      ),
    ),
    color: kQuestionTextColor,
    textColor: Colors.white,
    elevation: 8,
    //Creates circular edge on the top left corner of the Start button
    shape: RoundedRectangleBorder(
      borderRadius:
      new BorderRadius.only(topLeft: Radius.circular(50.0)),
    ),
  );
}



final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6BA7F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);


Widget buildFullNameTextField(
    {
      @required TextEditingController fullNameTextHolder
    }
    ) {
  return _buildTextBox(
    textBoxName: 'Full Name',
    icon: LineAwesomeIcons.envelope,
    text: fullNameTextHolder,
  );

}

Widget buildEmailTextField(
{
  @required TextEditingController emailTextHolder
}
    ) {
  return _buildTextBox(
    textBoxName: 'Email',
    icon: LineAwesomeIcons.envelope,
    text: emailTextHolder,
  );

}

Widget buildPasswordTextField({
  @required TextEditingController passwordTextHolder
}) {
  return _buildTextBox(
    textBoxName: 'Password',
    icon: LineAwesomeIcons.lock,
    obscureText: true,
    text: passwordTextHolder,
  );
}


Widget _buildTextBox({
  @required String textBoxName,
  @required IconData icon,
  @required TextEditingController text,
  bool obscureText=false,
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
          obscureText: obscureText,
          controller: text,
          onSubmitted: (String userInput){
            print("User Input: $userInput \n\n\n");
          },
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


OutlineButton getSignUpLogInWithGoogleButton({
  @required Color textColor,
  @required BuildContext context,
  String signInOrUpText='Sign In',
}) {
  return OutlineButton(
    splashColor: Colors.grey,
    onPressed: () {
      firebaseAuthInstance.signInWithGoogle().whenComplete(() async {
        print('Sign in complete!');

        print('\n\n Calling getUserEmail() from google signin button .whenComplete()\n\n');
        //print(firebaseAuthInstance.getUserEmail());
        firestoreSingleton.addUser(
            userEmail: await firebaseAuthInstance.getUserEmail(),
            firstName: firebaseAuthInstance.getFirstName(),
            lastName: firebaseAuthInstance.getLastName(),
          userPicture: firebaseAuthInstance.getUserPicture(),
        );

      }).catchError((error, stackTrace) {
        print("inner: $error");
        // although `throw SecondError()` has the same effect.
        Navigator.pushNamed(context, AppBottomNavigationBar.idToTopicScreen);
      });
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: textColor),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image(image: AssetImage("images/google_logo.png"), height: 35.0),
          Expanded(
            child: kCustomText(
              text: '$signInOrUpText with Google',
              minFontSize: 20.0,
              color: textColor,
            ),
          )
        ],
      ),
    ),
  );
}


void showAlert({
  @required BuildContext context,
  @required String alertTitle,
  @required String alertText,
  String mainButtonText='Okay',
  
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(alertTitle),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(alertText),
              //Text('Yre you sure about this?.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(mainButtonText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

          if(false) FlatButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop();
              //TODO: If points are being added while user is playing, make sure to not save it on firestore
              ///Pressing yes means exiting the round, so points shouldn't be saved
              Navigator.pushNamed(context, AppBottomNavigationBar.idToHomeScreen);
            },
          ),
        ],
      );
    },
  );
}