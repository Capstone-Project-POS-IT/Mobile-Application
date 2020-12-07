import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pos_it/Authentication/PasswordReset.dart';
import '../ExternalCalls.dart';
import '../Navibar.dart';
import 'EmailAuthentication.dart';
import '../UserInfo/UserInformation.dart';
import 'SignUp.dart';

//inputs
final TextEditingController _emailController = new TextEditingController();
final TextEditingController _passwordController = new TextEditingController();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPasswordObscure;

  @override
  void initState() {
    _isPasswordObscure = true;
    Firebase.initializeApp().then((value) {
      if (FirebaseAuth.instance.currentUser != null) {
        showSigningInDialog(context);
        FirebaseAuth.instance.currentUser.refreshToken;
        setAllUserInformation().whenComplete(
            () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => NaviView())));
      }
    });

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
                SizedBox(height: 70),
                Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xffDCFCDD),
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () => _signInViaFacebook(context),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Image(
                                image: AssetImage(
                                    "lib/assets/images/facebook_logo.png"),
                                width: 80,
                                height: 80))),
                    GestureDetector(
                      onTap: () => _signInViaGoogle(context),
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Image(
                              image: AssetImage(
                                  "lib/assets/images/google_logo.png"),
                              width: 80,
                              height: 80)),
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
                  height: 35,
                  color: Colors.white,
                  child: TextField(
                    controller: _emailController,
                    decoration: new InputDecoration(
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
                  height: 35,
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
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: ButtonTheme(
                        minWidth: 200,
                        height: 50,
                        child: FlatButton(
                          color: Color(0xffabd0a8),
                          onPressed: () => _signInViaEmail(_emailController.text,
                              _passwordController.text, context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text("Login",
                              style: TextStyle(
                                  color: Color(0xff000080), fontSize: 20)),
                        ))),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text("Don't have an account?",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 25))),
                ButtonTheme(
                    minWidth: 200,
                    height: 50,
                    child: FlatButton(
                      color: Color(0xffabd0a8),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text("Sign-up",
                          style: TextStyle(
                              color: Color(0xff000080), fontSize: 20)),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text("Forgot Password?",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 25))),
                ButtonTheme(
                    minWidth: 200,
                    height: 50,
                    child: FlatButton(
                      color: Color(0xffabd0a8),
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PasswordReset()))
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text("Send email",
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

showSigningInDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          height: 20,
          width: 40,
          child: SimpleDialog(
            children: [
              Text("Signing in...",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
              CircularProgressIndicator()
            ],
          ),
        );
      });
}

void _signInViaEmail(
    String userEmail, String userPassword, BuildContext context) async {
  await Firebase.initializeApp();
  try {
    User user = await Authentication.signInViaEmail(userEmail, userPassword);
    if (user != null) {
      if (user.emailVerified) {
        setAllUserInformation();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NaviView()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EmailAuthentication()));
      }
    }
  } catch (error) {
    //can use print(error.code); and  print(error.message);
    print("ERROR" + error.toString());

    //set the outline of the boxes to red

    //show the snackbar or the toast

    _emailController.text = "";
    _passwordController.text = "";
  }
}

void _signInViaGoogle(BuildContext context) async {
  User userFromGoogle = await Authentication.signInViaGoogle();
  if (userFromGoogle != null) {
    setAllUserInformation();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => NaviView()));
  }
}

void _signInViaFacebook(BuildContext context) async {
  User userFromFacebook = await Authentication.signInViaFacebook();
  if (userFromFacebook != null) {
    setAllUserInformation();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => NaviView()));
  }
}

Future<void> setAllUserInformation() async {
  UserInformation.initiateFirebaseUser();
  await UserInformation.setAllUserInformationData();
}


