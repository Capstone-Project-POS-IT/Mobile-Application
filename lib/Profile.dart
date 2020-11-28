import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pos_it/AccountConfirmation.dart';
import 'Authentication/Login.dart';
import 'ExternalCalls.dart';
import 'UserInfo/UserInformation.dart';

//TODO: bottom nav bar, fix buttons

const IconData account_circle_rounded =
    IconData(0xf03e, fontFamily: 'MaterialIcons');
const IconData create_rounded = IconData(0xf145, fontFamily: 'MaterialIcons');
const IconData email = IconData(0xe6f3, fontFamily: 'MaterialIcons');
const IconData bookmark = IconData(0xe5f8, fontFamily: 'MaterialIcons');
const IconData check_box = IconData(0xe64d, fontFamily: 'MaterialIcons');
const IconData power_settings_new =
    IconData(0xe949, fontFamily: 'MaterialIcons');

class ProfileView extends StatefulWidget {
  @override
  _ProfileView createState() => new _ProfileView();
}

class _ProfileView extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff131D47),
      body: Center(
        child: Column(
          children: <Widget>[
            Title(),

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountConfirmation()));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1D2D6B),
                  border: Border(
                    top: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                    bottom: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                  ),
                ),
                child: Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                    child: Icon(
                      Icons.create_rounded,
                      color: Colors.white,
                      size: 30,
                      semanticLabel: 'Edit profile',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Edit Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 20,
                            backgroundColor: Color(0xff1D2D6B))),
                  )
                ]),
              ),
            ),

            GestureDetector(
              onTap: () {
                //TODO
                //print("Container clicked");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1D2D6B),
                  border: Border(
                    top: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                    bottom: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                  ),
                ),
                child: Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                    child: Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 30,
                      semanticLabel: 'Email Verification',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Email Verification",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 20,
                            backgroundColor: Color(0xff1D2D6B))),
                  )
                ]),
              ),
            ),

            GestureDetector(
              onTap: () {
                //TODO
                //print("Container clicked");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1D2D6B),
                  border: Border(
                    top: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                    bottom: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                  ),
                ),
                child: Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                    child: Icon(
                      Icons.bookmark,
                      color: Colors.white,
                      size: 30,
                      semanticLabel: 'Saved Articles',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Saved Articles",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 20,
                            backgroundColor: Color(0xff1D2D6B))),
                  )
                ]),
              ),
            ),

            GestureDetector(
              onTap: () {
                //TODO
                //print("Container clicked");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1D2D6B),
                  border: Border(
                    top: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                    bottom: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                  ),
                ),
                child: Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                    child: Icon(
                      Icons.check_box,
                      color: Colors.white,
                      size: 30,
                      semanticLabel: 'Weekly Progress',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Weekly Progress",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 20,
                            backgroundColor: Color(0xff1D2D6B))),
                  )
                ]),
              ),
            ),

            GestureDetector(
              onTap: () {
                //TODO
                //print("Container clicked");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1D2D6B),
                  border: Border(
                    top: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                    bottom: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                  ),
                ),
                child: Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                    child: Icon(
                      Icons.check_box,
                      color: Colors.white,
                      size: 30,
                      semanticLabel: 'Monthly Progress',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Monthly Progress",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 20,
                            backgroundColor: Color(0xff1D2D6B))),
                  )
                ]),
              ),
            ),

            GestureDetector(
              onTap: () {
                Authentication.signOutUserAllPossibilities().then((value) =>
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login())));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1D2D6B),
                  border: Border(
                    top: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                    bottom: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                  ),
                ),
                child: Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                    child: Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                      size: 30,
                      semanticLabel: 'Logout',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Logout",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 20,
                            backgroundColor: Color(0xff1D2D6B))),
                  )
                ]),
              ),
            ),

            //End of all buttons
          ],
        ),
      ),
    );
  }
}

class Title extends StatefulWidget {
  @override
  _Title createState() => _Title();
}

class _Title extends State<Title> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 0, 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Image.asset("lib/assets/images/posit_logo.png"),
          ]),
          Align(
            alignment: Alignment.topRight,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.account_circle_rounded,
                  color: Colors.white,
                  size: 125,
                  semanticLabel: 'Account profile picture',
                ),
              ]),
          Align(
            alignment: Alignment.center,
            child: Text(UserInformation.getDisplayName(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xffDCFCDD),
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
          ),
        ],
      ),
    );
  }
}
