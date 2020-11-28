/*Class holds all of user information and preferences*/
import 'dart:async';
import 'dart:collection';
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
  static Map<String, dynamic> _map;

  /*Initiation functions*/
  static void initiateFirebaseUser() {
    _user = FirebaseAuth.instance.currentUser;
  }

  static User getUser(){
    return _user;
  }

  static Future<void> setAllUserInformationData() async {
    setUserBasedNews();
    setUserSentimentData();
  }

  static Future<void> setUserBasedNews() async{
    _userSentiBasedNews = Map<String, dynamic>.from(await APICall.getNewsHeadlinesSentiBased());
  }

  static Future<void> setUserSentimentData() async{
    _userSentimentData = (await APICall.getUserDaySentimentsData())["data"];
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

  static getUserSentimentMap() {
    if(_userSentimentData == null) {
      _map = new Map<String, dynamic>();
    } else if(_map==null) {
      _map = Map<String, dynamic>.from(_userSentimentData);
    }
    return _map;
  }

  static addUserSentimentData(DateTime key, double value,String description) {
    String todayDateFormatted = DateFormat('yyyy-MM-dd').format(key);
    dynamic newData = new HashMap();
    newData['sentiment'] = value;
    newData['description'] = description;
    _map[todayDateFormatted] = newData;
  }

  //get news based on the topic
  static List<dynamic> getNewsBasedOnTopic(String topic){
    return _userSentiBasedNews['articles'][topic];
  }

}
