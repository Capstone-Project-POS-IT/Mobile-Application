import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_it/SettingsViews/EditProfile.dart';
import 'package:pos_it/ExternalCalls.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountConfirmation extends StatefulWidget {
  @override
  _AccountConfirmationState createState() => _AccountConfirmationState();
}

class _AccountConfirmationState extends State<AccountConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff131d47),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Account Confirmation",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xffDCFCDD),
                        fontWeight: FontWeight.bold,
                        fontSize: 40)),
                Text(
                  "Please confirm your account before continuing to change account settings",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AccountCredential(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountCredential extends StatefulWidget {
  @override
  _AccountCredentialState createState() => _AccountCredentialState();
}

class _AccountCredentialState extends State<AccountCredential> {
  TextEditingController passwordController;
  bool userHasEmailOption;

  @override
  void initState() {
    passwordController = new TextEditingController();
    userHasEmailOption = false;
    for (UserInfo userInfo in UserInformation.getUser().providerData) {
      if (userInfo.providerId == "password") {
        userHasEmailOption = true;
        break;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 400,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xff1D2D6B),
            border: Border.all(width: 2, color: Colors.white)),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () =>
                    {_verifyAccountCredentialsViaSocialMedia("Facebook")},
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Image(
                      image: AssetImage("lib/assets/images/facebook_logo.png"),
                      width: 65,
                      height: 65),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    {_verifyAccountCredentialsViaSocialMedia("Google")},
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Image(
                      image: AssetImage("lib/assets/images/google_logo.png"),
                      width: 65,
                      height: 65),
                ),
              )
            ],
          ),
          userHasEmailOption == true
              ? AccountConfirmationEmailWidget()
              : Container()
        ]),
      ),
    );
  }

  void _verifyAccountCredentialsViaSocialMedia(String socialMedia) async {
    bool isAccountVerified = false;
    if (socialMedia == "Google") {
      isAccountVerified = await Authentication.reAuthenticateUserViaGoogle();
    } else {
      isAccountVerified = await Authentication.reAuthenticateUserViaFacebook();
    }

    if (isAccountVerified) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EditProfile()));
    }
  }
}

class AccountConfirmationEmailWidget extends StatefulWidget {
  @override
  _AccountConfirmationEmailWidgetState createState() =>
      _AccountConfirmationEmailWidgetState();
}

class _AccountConfirmationEmailWidgetState
    extends State<AccountConfirmationEmailWidget> {
  TextEditingController _passwordController;

  @override
  void initState() {
    _passwordController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("User Email:",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(UserInformation.getUser().email,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25, color: Colors.white)),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Password:",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Container(
              alignment: Alignment.bottomLeft,
              width: 350,
              height: 40,
              color: Colors.white,
              child: TextField(
                controller: _passwordController,
                decoration: new InputDecoration(
                  hintText: "Enter password",
                ),
                cursorHeight: 40,
                style: TextStyle(fontSize: 17, height: 2, color: Colors.black),
              ),
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: ButtonTheme(
                minWidth: 200,
                height: 50,
                child: FlatButton(
                  color: Color(0xffabd0a8),
                  onPressed: () =>
                      {_verifyAccountCredentials(_passwordController.text)},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Text("Verify Account",
                      style: TextStyle(color: Color(0xff000080), fontSize: 20)),
                ))),
      ],
    );
  }

  void _verifyAccountCredentials(String password) async {
    bool isAccountVerified =
        await Authentication.reAuthenticateUserViaPassword(password);
    if (isAccountVerified) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EditProfile()));
    }
  }
}
