import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
import 'package:pos_it/creators.dart';
import 'package:pos_it/ProvideFeedback.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              Container(
                color: Color(0xff1D2D6B),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.email,color: Colors.white),
                        Text(
                          "User Email: ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    Text(
                      UserInformation.getDisplayName(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
