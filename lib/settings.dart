import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pos_it/AccountConfirmation.dart';
import 'package:pos_it/Profile.dart';
import 'package:pos_it/creators.dart';
import 'package:pos_it/ProvideFeedback.dart';

//TODO: fix buttons, bottom nav bar

class SettingsView extends StatefulWidget {
  @override
  _SettingsView createState() => new _SettingsView();
}

class _SettingsView extends State<SettingsView> {
  void _goToCreators() {}
  void _goToProvideFeedback() {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff131D47),
      body: Center(
        child: Column(
          children: <Widget>[
            Title(),
            GestureDetector(
              onTap: (){
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
                    padding: EdgeInsets.all(15),
                    child: Text("Text Size",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xffFFFFFF), fontSize: 20, backgroundColor: Color(0xff1D2D6B))),
                  )
                ]),
              ),
            ),

            GestureDetector(
              onTap: (){
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
                    padding: EdgeInsets.all(15),
                    child: Text("Terms of Use",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xffFFFFFF), fontSize: 20, backgroundColor: Color(0xff1D2D6B))),
                  )
                ]),
              ),
            ),

            GestureDetector(
              onTap: (){
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
                    padding: EdgeInsets.all(15),
                    child: Text("Privacy Policy",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xffFFFFFF), fontSize: 20, backgroundColor: Color(0xff1D2D6B))),
                  )
                ]),
              ),
            ),

            GestureDetector(
              onTap: (){
                //TODO
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileView()));
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
                    padding: EdgeInsets.all(15),
                    child: Text("Profile Settings",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xffFFFFFF), fontSize: 20, backgroundColor: Color(0xff1D2D6B))),
                  )
                ]),
              ),
            ),

            GestureDetector(
              onTap: (){
                //TODO
                return MaterialApp(
                  home: CreatorsPage(),
                );
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
                    padding: EdgeInsets.all(15),
                    child: Text("About and Contact",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xffFFFFFF), fontSize: 20, backgroundColor: Color(0xff1D2D6B))),
                  )
                ]),
              ),
            ),

            GestureDetector(
              onTap: (){
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
                    padding: EdgeInsets.all(15),
                    child: Text("Provide Feedback",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xffFFFFFF), fontSize: 20, backgroundColor: Color(0xff1D2D6B))),
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
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("lib/assets/images/posit_logo.png", height:150),
          Align(
            alignment: Alignment.center,
            child: Text("Settings",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xffDCFCDD), fontWeight: FontWeight.bold, fontSize: 30)),
          ),
        ],
      ),
    );
  }
}
