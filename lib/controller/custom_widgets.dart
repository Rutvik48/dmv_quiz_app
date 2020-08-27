import 'package:dmvquizapp/controller/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:dmvquizapp/controller/quiz_class.dart' as quiz;

AutoSizeText kCustomText(
    {
      String text,
      Color color,
      TextAlign textAlign=TextAlign.center,
      fontWeight=FontWeight.normal,
      double maxFontSize=kDefaultMaxFontSize,
      double minFontSize=kDefaultMinFontSize,

    }) {
  return AutoSizeText(text,
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

Padding kOptionButton({@required String text, @required Function onPressed, Color borderColor}) {
  return Padding(
    padding: const EdgeInsets.only(
      left:kQuizScreenLeftRightPadding,
      right: kQuizScreenLeftRightPadding,
      top: 5.0,
      bottom: 5.0,
    ),
    child: RaisedButton(
      onPressed: onPressed,
      child: kCustomText(
        text: text,
        maxFontSize: kOptionsMaxFontSize,
        minFontSize: kOptionsMinFontSize,
      ),
      color: kLogoBackgroundColor,
      //textColor: kLogoMatchingColor,
      elevation: 8,
      //Creates circular edge on the top left corner of the Start button
      shape: new RoundedRectangleBorder(
        side: BorderSide(
            color: borderColor,
            width: 2,
            style: BorderStyle.solid
        ),
        borderRadius: new BorderRadius.all(Radius.circular(50.0)),
      ),
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

Center kDash (BuildContext context){
  return Center(
    child: Dash(
        direction: Axis.horizontal,
        length: MediaQuery.of(context).size.width/1.09,
        dashLength: 12,
        dashColor: kDividerLineColor
    ),
  );
}