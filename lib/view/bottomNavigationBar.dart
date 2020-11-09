import 'package:dmvquizapp/controller/firebase_auth_class.dart';
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
  static final firebaseAuthInstance = FirebaseAuthClass();

  final List<Widget> _screens = [
    WelcomeScreen(),
    UserScreen(),
    AboutScreen(),
    TopicScreen(),
  ];
//LoginScreen(),

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,

        onItemSelected: (index) {

          print ("This is index Number: $index");
          if (index == 1) {
            if (firebaseAuthInstance.getUserLoggedInStatus()){
              setState((){
                _currentIndex = index;
              } );
            } else {
              //kShowToast(toastMessage: null);
              kShowAlert(
                  context: context,
                  alertTitle: 'Sign In',
                  alertText: 'Sign in required to access user page. \n',
                  mainButtonOnTap: (){Navigator.of(context).pop();},
              );

            }
          } else if (index == 2){
            kShowAlert(
                context: context,
                alertTitle: 'Please Hold On!!',
                alertText: 'Work in progress for about us page. \n',
                mainButtonOnTap: (){Navigator.of(context).pop();}
            );
          }else {
            setState((){
              _currentIndex = index;
            } );
          }

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