import 'package:dmvquizapp/controller/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
