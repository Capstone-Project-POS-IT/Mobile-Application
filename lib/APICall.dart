import 'dart:async';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class APICall {

  //initialize the firebase if not initialized
  static Future<bool> _initializeFirebase() async {
    if (Firebase.apps.length == 0) {
      await Firebase.initializeApp();
    }
    return true;
  }

  /* Test the API
  - Parameters: None
  - Output: Prints API SUCCEEEDED if API connection works
   */
  static Future<void> testAPI() async {
    await _initializeFirebase();
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'testDemo',
    );
    dynamic resp =
    await callable.call(); //one time call function with no params
    if (resp.data['msg'] == "Hello from Firebase!") {
      print("API SUCCEEEDED!!!!!!!!!!!!!!!!!");
    } else {
      print("API failed :(");
    }
  }

  /*Test the API with Parameters
  - Parameters: name, date (as a string)
  - Output: Returns Hello from firebase message with name and string date.
            Will state API with Params succeeded if success
   */
  static Future<void> testAPIWithParams(String name, String date) async {
    await _initializeFirebase();
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
        functionName: "testDemoWithParams");
    dynamic resp = await callable.call(<String, dynamic>{
      'name': name,
      'date': date
    });
    print(resp.data);
    if (resp.data['msg'].toString().startsWith("Hello from Firebase")) {
      print("API WITH PARAMS SUCCEEEDED!!!!!!!!!!!!!!!!!");
    }
  }


  /*Get a randomly chosen quote
  - Parameters: None
  - Output JSON: {author:____,text:____}
  */
  static Future<List<String>> getInspirationalQuote() async {
    await _initializeFirebase();
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
        functionName: 'randomChosenInspirationalQuote'
    );
    var resp = await callable.call();
    print(resp.data);
  }

  /* Get all top headlines
  - Parameters: None
  - Output: Returns list of all main headlines
   */
  static Future<void> getNewsHeadlines() async {
    await _initializeFirebase();
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
        functionName: 'getTopNewsHeadlines'
    );
    var resp = await callable.call();
    print(resp.data);
  }

  /* Get Headlines based on sentiment of the user
  - Parameters: User sentiment (value between 1-10)
  - Output: Returns list of all headlines that follow the sentiment guidelines
   */
  static Future<void> getNewsHeadlinesSentiBased(int userSentiment) async {
    await _initializeFirebase();
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
        functionName: "getTopNewsSentiBased");
    dynamic resp = await callable.call(<String, dynamic>{
      "sentiment": userSentiment
    });
    print("Resp");
    print(resp.data);
  }


  static Future<void> createAccountId() async {
    await _initializeFirebase();
    /*will get a new id for which the user can use to send data.
    User ID will be saved to a temporary ID created location with a 24 hour timestamp. Is deleted afterwards
    if user does not use the ID.
    Returns the users chosen 6 digit ID.
     */
  }

  static Future<void> addUserData(List data, String password) async {
    await _initializeFirebase();
    int hashcodedPassword = password.hashCode;

    /*Will add data of user to the database. Will be saved under the ID of the user*/

  }

  static Future<void> getUserData(int id, String password) async {
    await _initializeFirebase();
    int hashcodedPassword = password.hashCode;

    /*Will add data of user to the database. Will be saved under the ID of the user*/

  }





}