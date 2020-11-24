import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_it/EditProfile.dart';
import 'package:pos_it/ExternalCalls.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pos_it/Authentication/PasswordReset.dart';

class AccountConfirmation extends StatefulWidget {
  @override
  _AccountConfirmationState createState() => _AccountConfirmationState();
}

class _AccountConfirmationState extends State<AccountConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff131d47),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Account Confirmation",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text(
                "Please confirm you account before continuing to change account settings",
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
    );
  }
}

class AccountCredential extends StatefulWidget {
  @override
  _AccountCredentialState createState() => _AccountCredentialState();
}

class _AccountCredentialState extends State<AccountCredential> {
  TextEditingController passwordController;

  @override
  void initState() {
    passwordController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 300,
        padding: EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Color(0xff1D2D6B),
            border: Border.all(width: 2, color: Colors.white)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  child: Text(UserInformation.get("email"),
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
                    controller: passwordController,
                    decoration: new InputDecoration(
                      hintText: "Enter password",
                    ),
                    cursorHeight: 40,
                    style:
                        TextStyle(fontSize: 17, height: 2, color: Colors.black),
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
                          _verifyAccountCredentials(passwordController.text),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text("Verify Account",
                          style: TextStyle(
                              color: Color(0xff000080), fontSize: 20)),
                    ))),
          ],
        ),
      ),
    );
  }

  void _verifyAccountCredentials(String password) async {
    bool accountVerified = await Authentication.reAuthenticateUserWithPassword(password);
    if(accountVerified){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
    }
  }
}
