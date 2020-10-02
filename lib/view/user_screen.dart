import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/controller/firebase_auth_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  FirebaseAuthClass firebaseAuthSingleton = FirebaseAuthClass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('fetching userinfo in init');
    firebaseAuthSingleton.fillUserInformation();
    print('Last line of init');


  }
  //
  // void doInitialSetup() async {
  //
  //   await
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    return SafeArea(
      child: Center(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            _getUserInfoWidget(),

            SizedBox(
              height: 100.0,
              child: Container(
                child: kCustomText(text: 'Progress Bar'),
                color: Colors.black12,
              ),
            ),

            Expanded(
              flex: 3,
              child: Container(
                child: kCustomText(text: 'Recent Activity'),
                color: Colors.grey,
              ),
            ),


          ],
        ),
      ),
    );
  }

  Expanded _getUserInfoWidget() {
    return Expanded(
            flex: 1,
            child: Container(
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  getUserImageWidget(),

                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kCustomText(
                              text: firebaseAuthSingleton.getUserEmail(),
                              fontWeight: FontWeight.bold,
                              color: kLogoMatchingColor,
                              minFontSize: 20.0
                            ),
                            kCustomText(
                                text: firebaseAuthSingleton.getUserName(),
                                fontWeight: FontWeight.bold,
                                color: kLogoMatchingColor,
                                minFontSize: 20.0
                            ),
                            kCustomText(
                                text: 'click here to change password.',
                                fontWeight: FontWeight.w100,
                                color: kLogoMatchingColor,
                                minFontSize: 10.0
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget getUserImageWidget() {
    return Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                firebaseAuthSingleton.getUserPicture())
                        )
                    ));
  }
}

