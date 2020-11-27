import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_it/ExternalCalls.dart';

import '../Home.dart';

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  ScrollController _passResetscrollController;
  TextEditingController _emailController,
      _emailVerificationCodeController,
      _passwordController;
  double _emailAuthOpacity, _passwordAuthOpacity;
  bool _emailTextFieldEnabled,
      _emailVerificationCodeTextFieldEnabled,
      _passwordTextFieldEnabled;

  void initState() {
    _passResetscrollController = new ScrollController();
    _emailAuthOpacity = 1;
    _passwordAuthOpacity = 0.3;
    _emailTextFieldEnabled = true;
    _emailVerificationCodeTextFieldEnabled = false;
    _passwordTextFieldEnabled = false;
    _emailController = new TextEditingController();
    _emailVerificationCodeController = new TextEditingController();
    _passwordController = new TextEditingController();
    super.initState();
  }

  void _changeOpacitiesAfterEmailAuth() {
    _passResetscrollController.animateTo(150,
        duration: Duration(seconds: 1), curve: Curves.ease);
    setState(() {
      _emailAuthOpacity = 0.3;
      _passwordAuthOpacity = 1;
      _emailTextFieldEnabled = false;
      _emailVerificationCodeTextFieldEnabled = true;
      _passwordTextFieldEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xff131d47),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("Password Reset For POS-IT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xffDCFCDD),
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  Container(
                    height: 500,
                    child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _passResetscrollController,
                        child: Column(
                          children: <Widget>[
                            Opacity(
                              opacity: _emailAuthOpacity,
                              child: Column(
                                children: <Widget>[
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              25, 10, 0, 10),
                                          child: Text("Email",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)))),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    width: 350,
                                    height: 40,
                                    color: Colors.white,
                                    child: TextField(
                                      enabled: _emailTextFieldEnabled,
                                      controller: _emailController,
                                      style: TextStyle(
                                          fontSize: 17,
                                          height: 2,
                                          color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  ButtonTheme(
                                      minWidth: 200,
                                      height: 50,
                                      child: FlatButton(
                                        color: Color(0xffabd0a8),
                                        onPressed: () {
                                          _changeOpacitiesAfterEmailAuth();
                                          _sendEmailAuthCode();
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        child: Text("Send email",
                                            style: TextStyle(
                                                color: Color(0xff000080),
                                                fontSize: 20)),
                                      ))
                                ],
                              ),
                            ),
                            Opacity(
                              opacity: _passwordAuthOpacity,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.all(25),
                                      child: Text(
                                          "Please verify your email by typing in the ten character code received in your email inbox",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              25, 10, 0, 10),
                                          child: Text("Email verification code",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)))),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    width: 350,
                                    height: 40,
                                    color: Colors.white,
                                    child: TextField(
                                      enabled:
                                          _emailVerificationCodeTextFieldEnabled,
                                      controller:
                                          _emailVerificationCodeController,
                                      maxLength: 10,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 17,
                                          height: 2,
                                          color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              25, 10, 0, 10),
                                          child: Text("Enter new password",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)))),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    width: 350,
                                    height: 40,
                                    color: Colors.white,
                                    child: TextField(
                                      enabled: _passwordTextFieldEnabled,
                                      controller: _passwordController,
                                      style: TextStyle(
                                          fontSize: 17,
                                          height: 2,
                                          color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  ButtonTheme(
                                      minWidth: 200,
                                      height: 50,
                                      child: FlatButton(
                                        color: Color(0xffabd0a8),
                                        onPressed: () => {_confirmEmailAuthCodeAndResetPassword()},
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        child: Text("Submit",
                                            style: TextStyle(
                                                color: Color(0xff000080),
                                                fontSize: 20)),
                                      )),
                                  SizedBox(height: 300)
                                ],
                              ),
                            )
                          ],
                        )),
                  )
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

  void _sendEmailAuthCode() {
    String email = _emailController.text;
    Authentication.sendResetPasswordAuthenticationEmail(email);
  }

  void _confirmEmailAuthCodeAndResetPassword() async {
    String email = _emailController.text;
    String userAuthCodeInput = _emailVerificationCodeController.text;
    String newPassword = _passwordController.text;
    dynamic response = await Authentication.verifyEmailAuthCodeAndResetPassword(
        userAuthCodeInput, email, newPassword);
    if (response["passwordReset"] == true) {
      //add later that password was reset
      Navigator.pop(context);
    }
  }
}
