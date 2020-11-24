import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pos_it/ExternalCalls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pos_it/ExternalCalls.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
import 'package:pos_it/creators.dart';
import 'package:pos_it/ProvideFeedback.dart';

import 'Authentication/Login.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isEditingEmail, _isEditingDisplayName, _isEditingPassword;
  TextEditingController _emailController,
      _displayNameController,
      _passwordController;
  String _userEmail, _userDisplayName, _userPasswordStars;

  @override
  void initState() {
    super.initState();
    _isEditingEmail = false;
    _isEditingDisplayName = false;
    _isEditingPassword = false;
    _emailController = new TextEditingController();
    _displayNameController = new TextEditingController();
    _passwordController = new TextEditingController();
    _userEmail = UserInformation.get("email");
    _userDisplayName = UserInformation.getDisplayName();
    _userPasswordStars = "*****";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff131d47),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("Edit Profile ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 45)),
              ),
              SizedBox(
                height: 100,
              ),

              /*Below are the Editing profile options*/
              GestureDetector(
                onTap: () {
                  _showOptionToEdit("email");
                },
                child: EditProfileOption(Icons.email, "Email:", _userEmail),
              ),
              GestureDetector(
                  onTap: () {
                    _showOptionToEdit("display name");
                  },
                  child: EditProfileOption(
                      Icons.expand, "Display Name:", _userDisplayName)),
              _isEditingDisplayName == true
                  ? Container(
                      alignment: Alignment.bottomLeft,
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      color: Colors.white,
                      child: TextField(
                        controller: _displayNameController,
                        decoration: InputDecoration(
                            hintText: "Enter new display name",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.check_circle),
                              onPressed: () {
                                _setUpdatedProfile("displayName");
                              },
                            )),
                        style: TextStyle(
                            fontSize: 17, height: 2, color: Colors.black),
                      ),
                    )
                  : Container(),
              GestureDetector(
                onTap: () {
                  _showOptionToEdit("password");
                },
                child: EditProfileOption(
                    Icons.margin, "Password:", _userPasswordStars),
              ),
              _isEditingPassword == true
                  ? Container(
                      alignment: Alignment.bottomLeft,
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      color: Colors.white,
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            hintText: "Enter new password",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.check_circle),
                              onPressed: () {
                                _setUpdatedProfile("password");
                              },
                            )),
                        style: TextStyle(
                            fontSize: 17, height: 2, color: Colors.black),
                      ),
                    )
                  : Container(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              GestureDetector(
                onTap: () => _deleteDataOptions("sentiment data"),
                child: EditProfileOption(
                    Icons.delete, "Delete all sentiment data", ""),
              ),
              GestureDetector(
                  onTap: () => _deleteDataOptions("account"),
                  child: EditProfileOption(
                      Icons.delete_forever, "Delete account", ""))
            ],
          ),
        ),
      ),
    );
  }

  void _showOptionToEdit(String option) {
    setState(() {
      switch (option) {
        case "email":
          _isEditingEmail = !_isEditingEmail;
          break;
        case "display name":
          _isEditingDisplayName = !_isEditingDisplayName;
          break;
        case "password":
          _isEditingPassword = !_isEditingPassword;
          break;
      }
    });
  }

  void _setUpdatedProfile(String option) async {
    switch (option) {
      case "displayName":
        await Authentication.updateUserDisplayName(_displayNameController.text);
        setState(() {
          _isEditingDisplayName = false;
          _userDisplayName = FirebaseAuth.instance.currentUser.displayName;
          _displayNameController.text = "";
        });
        break;
      case "password":
        await Authentication.updateUserPassword(_passwordController.text);
        setState(() {
          _isEditingPassword = false;
          _userPasswordStars = "Updated Password";
          _passwordController.text = "";
        });
        break;
    }
  }

  void _deleteDataOptions(String option) {
    switch (option) {
      case "sentiment data":
        showDeleteDataDialog(context, "Deleting Sentiment Data",
            "Are you sure you want to delete all sentiment data", false);
        break;
      case "account":
        showDeleteDataDialog(context, "Deleting Account",
            "Are you sure you want to delete your account", true);
        break;
    }
  }
}

class EditProfileOption extends StatefulWidget {
  IconData icon;
  String option;
  String usersInfoOfOption;

  EditProfileOption(IconData icon, String option, String usersInfoOfOption) {
    this.icon = icon;
    this.option = option;
    this.usersInfoOfOption = usersInfoOfOption;
  }

  @override
  _EditProfileOptionState createState() => _EditProfileOptionState();
}

class _EditProfileOptionState extends State<EditProfileOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 15, 0, 5),
          decoration: BoxDecoration(
            color: Color(0xff1D2D6B),
            border: Border(
              top: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
              bottom: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
            ),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                      child: Icon(
                        widget.icon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(widget.option,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 20,
                              backgroundColor: Color(0xff1D2D6B))),
                    ),
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 15, 10),
                    child: Text(
                      widget.usersInfoOfOption,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ]),
        ),
      ],
    );
  }
}

showDeleteDataDialog(
    BuildContext context, String title, String content, bool deletingAccount) {
  Future<void> yesOption() async {
    if (!deletingAccount) {
      //deleteting sentiment data
      await APICall.deleteAllUserSentimentData();
      Navigator.pop(context);
    } else {
      //deleting the account
      Authentication.deleteUserAccount().then((value) =>
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login())));
    }
  }

  void noOption() {
    Navigator.pop(context);
  }

  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          height: 20,
          width: 40,
          child: AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              FlatButton(
                  onPressed: () {
                    noOption();
                  },
                  child: Text("No")),
              FlatButton(
                  onPressed: () {
                    yesOption();
                  },
                  child: Text("Yes"))
            ],
          ),
        );
      });
}
