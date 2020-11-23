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
                              Icons.email,
                              color: Colors.white,
                              size: 30,
                              semanticLabel: 'username ',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Text("User Email:",
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
                            UserInformation.get("email"),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
