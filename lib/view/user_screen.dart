import 'dart:io';
import 'package:dmvquizapp/controller/constants.dart';
import 'package:dmvquizapp/controller/firebase/firebase_storage_class.dart';
import 'package:dmvquizapp/controller/firebase/firebase_auth_class.dart';
import 'package:dmvquizapp/view/bottomNavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dmvquizapp/controller/custom_widgets.dart';
import 'package:image_picker/image_picker.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  FirebaseAuthClass firebaseAuthSingleton = FirebaseAuthClass();
  TextEditingController textFieldText;
  String userProfilePicUrl;

  @override
  void initState() {
    super.initState();

    //Initializing Variables
    textFieldText = TextEditingController (text: '${firebaseAuthSingleton.getFirstName()}');
    userProfilePicUrl = firebaseAuthSingleton.getUserPicture();

    print('Here is image URL: $userProfilePicUrl');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
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
                      buildSignOutText(),

                      kClickableText(
                        context: context,
                        text: '${firebaseAuthSingleton.getFirstName()}',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        onTap: () {
                          kShowAlert(
                              context: context,
                              alertTitle: 'User Name',
                              alertText: 'Would you like to change user name?',
                              mainButtonText: 'Change Name',
                              showTextField: true,
                              textFieldTextController: textFieldText,
                              mainButtonOnTap: () {
                                print('Test------------------');
                                print('2 This is the full name ----> ${textFieldText.text}');
                                firebaseAuthSingleton.changeUserName(textFieldText.text);

                                //firebaseAuthInstance.signOutUser();
                                //Navigator.pushNamed(context, AppBottomNavigationBar.idToHomeScreen);
                              });
                        },


                      ),
                      // kCustomText(
                      //     text: '${firebaseAuthSingleton.getFirstName()} ${firebaseAuthSingleton.getLastName()}',
                      //     fontWeight: FontWeight.bold,
                      //     color: kLogoMatchingColor,
                      //     minFontSize: 20.0),
                      kCustomText(
                          text: 'click here to change password.',
                          fontWeight: FontWeight.w100,
                          color: kLogoMatchingColor,
                          minFontSize: 10.0),
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

  Align buildSignOutText() {
    return Align(
      alignment: Alignment.topRight,
      child: kClickableText(
        text: 'Sign out?',
        context: context,
        fontSize: 15.0,
        onTap: () {
          kShowAlert(
              context: context,
              alertTitle: 'Sign Out',
              alertText: 'Would you like to sign out?',
              mainButtonText: 'Yes',
              mainButtonOnTap: () async {
                await firebaseAuthInstance.signOutUser();
                Navigator.pushNamed(
                    context, AppBottomNavigationBar.idToHomeScreen);
              });
        },
      ),
    );
  }

  Widget getUserImageWidget() {
    return GestureDetector(
      onTap: () async {
        print("Opening Gallery");
        PickedFile imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
        print("Image path: ${imageFile.path}");
        File image = File(imageFile.path);


        FirebaseStorageClass firebaseStorageClass = FirebaseStorageClass();
        String userURL = await firebaseStorageClass.uploadFile(image);
        print("Here is new URL: $userURL");
        firebaseAuthSingleton.changeUserImage(userURL);
        setState(() {
          userProfilePicUrl = firebaseAuthSingleton.getUserPicture();
        });
      },
      child: Container(
          width: 150.0,
          height: 150.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image:
                      new NetworkImage(userProfilePicUrl)))),
    );
  }
}
