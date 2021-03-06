import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pos_it/Authentication/EmailAuthentication.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
import 'package:pos_it/ExternalCalls.dart';

import '../Navibar.dart';

//inputs
final TextEditingController _emailController = new TextEditingController();
final TextEditingController _passwordController = new TextEditingController();

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isPasswordObscure;

  @override
  void initState() {
    _isPasswordObscure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xff131d47),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.fromLTRB(0, 70, 0, 0)),
                Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xffDCFCDD),
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      "Sign-up with:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => _createUserAccountViaFacebook(context),
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Image(
                              image: AssetImage(
                                  "lib/assets/images/facebook_logo.png"),
                              width: 80,
                              height: 80)),
                    ),
                    GestureDetector(
                      onTap: () => _createUserAccountViaGoogle(context),
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Image(
                            image:
                                AssetImage("lib/assets/images/google_logo.png"),
                            width: 80,
                            height: 80,
                          )),
                    )
                  ],
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 10),
                        child: Text("Email",
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)))),
                Container(
                  alignment: Alignment.bottomLeft,
                  width: 350,
                  height: 40,
                  color: Colors.white,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      hintText: "Account Email",
                    ),
                    cursorHeight: 35,
                    style:
                        TextStyle(fontSize: 17, height: 2, color: Colors.black),
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 10),
                        child: Text("Password",
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)))),
                Container(
                  alignment: Alignment.bottomLeft,
                  width: 350,
                  height: 40,
                  color: Colors.white,
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye,
                            color: _isPasswordObscure?Colors.blue:Colors.red,
                          ),
                          onPressed:()=> _changePasswordObscurity() ,
                        )
                    ),
                    cursorHeight: 35,
                    obscureText: _isPasswordObscure,
                    style:
                        TextStyle(fontSize: 17, height: 2, color: Colors.black),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                    child: ButtonTheme(
                        minWidth: 200,
                        height: 50,
                        child: FlatButton(
                          color: Color(0xffabd0a8),
                          onPressed: () => _createUserAccount(
                              _emailController.text,
                              _passwordController.text,
                              context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text("Create account",
                              style: TextStyle(
                                  color: Color(0xff000080), fontSize: 20)),
                        ))),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Text("Already have an account?",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 25))),
                ButtonTheme(
                    minWidth: 100,
                    height: 50,
                    child: FlatButton(
                      color: Color(0xffabd0a8),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text("Login",
                          style: TextStyle(
                              color: Color(0xff000080), fontSize: 20)),
                    ))
              ],
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
            child: Image.asset("lib/assets/images/posit_logo.png"))
      ],
    );
  }

  void _changePasswordObscurity(){
    setState(() {
      _isPasswordObscure = !_isPasswordObscure;
    });
  }

}

//Create the user account (currently based more on email)
void _createUserAccount(
    String userEmail, String userPassword, BuildContext context) async {
  await Firebase.initializeApp();
  try {
    User user = await Authentication.signUpViaEmaiL(userEmail, userPassword);
    if (user != null) {
      //will update the user information here
      UserInformation.initiateFirebaseUser();
      UserInformation.setAllUserInformationData();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => EmailAuthentication()));
    }
  } catch (error) {
    print(error);
    _emailController.text = "";
    _passwordController.text = "";
  }
}

void _createUserAccountViaGoogle(BuildContext context) async {
  User userFromGoogle = await Authentication.signInViaGoogle();
  if (userFromGoogle != null) {
    UserInformation.initiateFirebaseUser();
    UserInformation.setAllUserInformationData();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => NaviView()));
  }
}

void _createUserAccountViaFacebook(BuildContext context) async {
  User userFromFacebook = await Authentication.signInViaFacebook();
  if (userFromFacebook != null) {
    UserInformation.initiateFirebaseUser();
    UserInformation.setAllUserInformationData();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => NaviView()));
  }

}
