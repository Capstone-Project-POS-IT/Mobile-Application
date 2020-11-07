import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:pos_it/ExternalCalls.dart';

import '../home.dart';

//inputs
final TextEditingController _inputAuthenticationCode = new TextEditingController();
final TextEditingController _inputDisplayName = new TextEditingController();

class EmailAuthentication extends StatefulWidget {
  @override
  _EmailAuthenticationState createState() => _EmailAuthenticationState();
}

class _EmailAuthenticationState extends State<EmailAuthentication> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xff000080),
          body: SingleChildScrollView(
            child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center
              children: [
                SizedBox(height: 100),
                Text("Thank you for creating an account with POS-IT!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.all(25),
                child:Text("Please verify your email by typing in the six digit code received in your email inbox",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontSize: 20))),
                Align(
                    alignment: Alignment.centerLeft,
                    child:Padding(padding: EdgeInsets.fromLTRB(25, 10, 0, 10),
                        child: Text("Email verification code:",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white,fontSize: 20)))
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  width: 350,
                  height: 40,
                  color: Colors.white,
                  child: TextField(
                    controller: _inputAuthenticationCode,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontSize: 17,
                        height: 2,
                        color: Colors.black
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Align(
                    alignment: Alignment.centerLeft,
                    child:Padding(padding: EdgeInsets.fromLTRB(25, 10, 0, 10),
                        child: Text("Enter your name for the app",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white,fontSize: 20)))
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  width: 350,
                  height: 40,
                  color: Colors.white,
                  child: TextField(
                    controller: _inputDisplayName,
                    style: TextStyle(
                        fontSize: 17,
                        height: 2,
                        color: Colors.black
                    ),
                  ),
                ),
              SizedBox(height: 30),
              ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  child: FlatButton(
                    color: Color(0xffabd0a8),
                    onPressed: ()=>{_confirmEmailAuthCodeAndName() },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text("Submit",
                        style: TextStyle(color: Color(0xff000080),fontSize: 20)),
                  )
              ),
                SizedBox(height: 20),
                Padding(padding: EdgeInsets.all(20),
                child: Text("Didn't receive an email or misplaced it?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20,color: Colors.white,))),
                ButtonTheme(
                    minWidth: 150,
                    height: 50,
                    child: FlatButton(
                      color: Color(0xffabd0a8),
                      onPressed: ()=>{_resendEmailAuthCode()},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text("Resend Email",
                          style: TextStyle(color: Color(0xff000080),fontSize: 20)),
                    )
                ),
              ],
            ),
          ),
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
            child: Image.asset("lib/assets/images/posit_logo.png"))
      ],
    );
  }

  void _confirmEmailAuthCodeAndName() async{
   dynamic response = await Authentication.emailAuthenticationAndAddDisplayName(_inputAuthenticationCode.text, _inputDisplayName.text);
   if(response["emailAuthenticated"]==true){
     Navigator.push(context,MaterialPageRoute(builder: (context) => HomeView()));
   }
   else{
     //say there was an error.... say what the error is.
   }
  }

  void _resendEmailAuthCode(){
    Authentication.sendEmailAuthenticationEmail(true);
  }
}
