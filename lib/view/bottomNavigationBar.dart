import 'package:dmvquizapp/view/about_screen.dart';
import 'package:dmvquizapp/view/quiz_screen.dart';
import 'package:dmvquizapp/view/result_screen.dart';
import 'package:dmvquizapp/view/topic_screen.dart';
import 'package:dmvquizapp/view/user_screen.dart';
import 'package:dmvquizapp/view/welcom_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/constants.dart';
import 'quiz_screen.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:dmvquizapp/controller/firestore_class.dart';


class AppBottomNavigationBar extends StatefulWidget {

  static const String id = 'bottomNavigationBar';

  //final boolean;
  //AppBottomNavigationBar({@required this.boolean});

  static int currentIndex;
  init({@required int indexNumber}){
    currentIndex = indexNumber;
  }

  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  static int _currentIndex = 0;

  final List<Widget> _screens = [
    WelcomeScreen(),
    AboutScreen(),
    UserScreen(),
    TopicScreen(),
  ];


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // backgroundColor: Colors.redAccent,
        // selectedItemColor: kLogoBackgroundColor,
        // unselectedItemColor: Colors.black,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: kCustomText(text: 'Home'),
            backgroundColor: kLogoMatchingColor
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: kCustomText(text: 'About'),
              backgroundColor: kLogoMatchingColor
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: kCustomText(text: 'User'),
              backgroundColor: kLogoMatchingColor
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            title: kCustomText(text: 'Play'),
              backgroundColor: kLogoMatchingColor
          ),
        ],

        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },

      ),
    );
  }
}
