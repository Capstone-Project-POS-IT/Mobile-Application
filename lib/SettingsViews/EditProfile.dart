import 'package:firebase_auth/firebase_auth.dart';
import 'package:pos_it/ExternalCalls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';

import '../Authentication/Login.dart';

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
    _userEmail = UserInformation.getUser().email;
    _userDisplayName = UserInformation.getDisplayName();
    _userPasswordStars = "*****";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff131d47),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Edit Profile ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xffDCFCDD),
                          fontWeight: FontWeight.bold,
                          fontSize: 40)),
                ),
                Text(
                  "Click on the options below to edit your profile. ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
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
                              contentPadding: EdgeInsets.all(5),
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
                              contentPadding: EdgeInsets.all(5),
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
                        Icons.delete_forever, "Delete account", "")),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: ButtonTheme(
                        minWidth: 200,
                        height: 50,
                        child: FlatButton(
                          color: Color(0xffabd0a8),
                          onPressed: () => {
                            Navigator.pop(context),
                            Navigator.pop(context),
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text("Back to Profile Settings",
                              style: TextStyle(
                                  color: Color(0xff000080), fontSize: 20)),
                        )))
              ],
            ),
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

  //changes in email, display name, or password
  void _setUpdatedProfile(String option) async {
    switch (option) {
      case "displayName":
        if (_displayNameController.text.isNotEmpty) {
          await Authentication.updateUserDisplayName(
              _displayNameController.text);
          setState(() {
            _userDisplayName = FirebaseAuth.instance.currentUser.displayName;
            _displayNameController.text = "";
          });
        }
        setState(() {
          _isEditingDisplayName = false;
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

  //delete sentiment data or account
  void _deleteDataOptions(String option) {
    switch (option) {
      case "sentiment data":
        showDeleteDataDialog(
            context,
            "Deleting Sentiment Data",
            TextStyle(color: Colors.black, fontSize: 25),
            "Are you sure you want to delete all sentiment data?",
            false);
        break;
      case "account":
        showDeleteDataDialog(
            context,
            "WARNING! Deleting Account",
            TextStyle(color: Colors.red, fontSize: 30),
            "Are you sure you want to delete your POS-IT account?",
            true);
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

//Dialog that shows up when deleting user sentiment data or the account
showDeleteDataDialog(BuildContext context, String title,
    TextStyle titleTextStyle, String content, bool deletingAccount) {
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
            title:
                Text(title, textAlign: TextAlign.center, style: titleTextStyle),
            content: Text(content,textAlign: TextAlign.center),
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
