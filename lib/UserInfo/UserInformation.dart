/*Class holds all of user information and preferences*/
import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pos_it/ExternalCalls.dart';
import 'package:intl/intl.dart';

class UserInformation {

  //Data to be stored of the user
  static User _user; //will be the Firebase User
  static Map _userSentiBasedNews;
  static dynamic _userSentimentData;
  static Map<String, dynamic> map;

  /*Initiation functions*/
  static void initiateFirebaseUser(User userCreate) {
    _user = userCreate;
  }

  static Future<void> setAllUserInformationData() async {
    _userSentiBasedNews = Map<String, dynamic>.from(await APICall.getNewsHeadlinesSentiBased());
    _userSentimentData = await APICall.getUserDaySentimentsData();
    //print(_userSentimentData);
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

  static getUserSentimentMap() {
    dynamic jsonName = UserInformation.get("sentimentData");
    dynamic userData = jsonName["data"];

    map = Map<String, dynamic>.from(userData);

    return map;
  }

  static addUserSentimentData(DateTime key, double value) {
    String todayDateFormatted = DateFormat('yyyy-MM-dd').format(key);
    map[todayDateFormatted] = value;
  }

  //get news based on the topic
  static List<dynamic> getNewsBasedOnTopic(String topic){
    return _userSentiBasedNews['articles'][topic];
  }

}
