import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';

class ResultScreen extends StatelessWidget {
  static const String id = 'result_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: kCustomText(text:'Quiz Result'),
        ),
        body: Column(
          children: [

            //TODO: Before Scrollview show how many questions were correct
            kCustomText(
              text: "You ansered 18/20 correctly",
              fontWeight: FontWeight.bold,
              textSize: 30.0,
            ),

            //TODO: Add Scrollable Page to show questions, answers and what user entered

          ],
        ),
    );
  }
}
