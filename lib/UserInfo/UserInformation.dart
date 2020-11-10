/*Class holds all of user information and preferences*/
import 'package:cloud_functions/cloud_functions.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pos_it/ExternalCalls.dart';

class UserInformation {

  //Data to be stored of the user
  static User _user; //will be the Firebase User
  static dynamic _userSentiBasedNews;
  static dynamic _userSentimentData;

  /*Initiation functions*/
  static void initiateFirebaseUser(User userCreate) {
    _user = userCreate;
  }

  static Future<void> setAllUserInformationData() async {
    _userSentiBasedNews = await APICall.getNewsHeadlinesSentiBased();
    _userSentimentData = await APICall.getUserDaySentimentsData();
  }

  //Get Information about the user
  static String getDisplayName(){
    if(_user==null){
      return "Unknown Yet";
    }
    else{
      return _user.displayName;
    }
  }

  static dynamic get(String info){
    switch(info){
      case "displayName":{
        return _user.displayName;
      }
      case "news":{
        return _userSentiBasedNews;
      }
      case "sentimentData":{
        return _userSentimentData;
      }
    }
  }


}
