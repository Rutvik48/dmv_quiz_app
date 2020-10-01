import 'package:dmvquizapp/view/about_screen.dart';
import 'package:dmvquizapp/view/login_screen.dart';
import 'package:dmvquizapp/view/topic_screen.dart';
import 'package:dmvquizapp/view/user_screen.dart';
import 'package:dmvquizapp/view/welcom_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';


class AppBottomNavigationBar extends StatefulWidget {

  static const String idToHomeScreen = 'bottomNavigationBarHome';
  static const String idToTopicScreen = 'bottomNavigationBarTopic';


  static int currentIndex;

  AppBottomNavigationBar ({@required int indexNumber}){
    currentIndex = indexNumber;
  }

  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _currentIndex = AppBottomNavigationBar.currentIndex;
  final List<Widget> _screens = [
    WelcomeScreen(),
    LoginScreen(),
    AboutScreen(),
    TopicScreen(),
  ];
//UserScreen(),

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,

        onItemSelected: (index) {
          setState(() => _currentIndex = index);
        },

        items: <BottomNavyBarItem>[
          getBottomNavyBarItem( icon: LineAwesomeIcons.home, iconText: 'Home Page'),
          getBottomNavyBarItem( icon: LineAwesomeIcons.user, iconText: 'User Info'),
          getBottomNavyBarItem( icon: LineAwesomeIcons.info, iconText: 'About Us'),
          getBottomNavyBarItem( icon: LineAwesomeIcons.arrow_right, iconText: 'Play'),
        ],
      ),
    );
  }

  BottomNavyBarItem getBottomNavyBarItem({@required IconData icon, @required String iconText}) {
    return BottomNavyBarItem(
            title: kCustomText(text: iconText, fontWeight: FontWeight.bold, color: kLogoMatchingColor),
            icon: Icon( icon, color: kLogoMatchingColor, size: 30,)
        );
  }

  //Icon getNavigationIcon(Icons icon, ) => Icon(Icons.play_arrow, color: kLogoMatchingColor,);
}











// bottomNavigationBar: BottomNavigationBar(
//   currentIndex: _currentIndex,
//   backgroundColor: Colors.redAccent,
//   selectedItemColor: kLogoBackgroundColor,
//   unselectedItemColor: Colors.black,
//
//   items: [
//     BottomNavigationBarItem(
//       icon: Icon(Icons.home),
//       title: kCustomText(text: 'Home'),
//       //backgroundColor: kLogoMatchingColor
//     ),
//
//     BottomNavigationBarItem(
//       icon: Icon(Icons.info),
//       title: kCustomText(text: 'About'),
//         //backgroundColor: kLogoMatchingColor
//     ),
//
//     BottomNavigationBarItem(
//       icon: Icon(Icons.account_circle),
//       title: kCustomText(text: 'User'),
//         //backgroundColor: kLogoMatchingColor
//     ),
//
//     BottomNavigationBarItem(
//       icon: Icon(Icons.play_arrow),
//       title: kCustomText(text: 'Play'),
//         //backgroundColor: kLogoMatchingColor
//     ),
//   ],
//
//   onTap: (index){
//     setState(() {
//       _currentIndex = index;
//     });
//   },
//
// ),