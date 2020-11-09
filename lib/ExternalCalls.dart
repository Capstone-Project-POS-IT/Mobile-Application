import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//for google
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  - Return: Void
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
  - Parameters: name (string), date (string)
  - Return: Void
  - Output: Returns Hello from firebase message with name and string date.
            Will state API with Params succeeded if success
   */
  static Future<void> testAPIWithParams(String name, String date) async {
    await _initializeFirebase();
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: "testDemoWithParams");
    dynamic resp =
        await callable.call(<String, dynamic>{'name': name, 'date': date});
    print(resp.data);
    if (resp.data['msg'].toString().startsWith("Hello from Firebase")) {
      print("API WITH PARAMS SUCCEEEDED!!!!!!!!!!!!!!!!!");
    }
  }

  /*Get a randomly chosen quote
  - Parameters: None
  - Return: JSON with author and quote
  - Output JSON: {author:____,text:____}
  */
  static Future<String> getInspirationalQuote() async {
    await _initializeFirebase();
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'randomChosenInspirationalQuote');
    var resp = await callable.call();
    var data = resp.data;
    var quote = data.values.toList();
    return quote[1] + " -" + quote[0];
  }

  /* Retrieves all of the news from database that are filtered based on user's most recent sentiment
  - Parameters: None
  - Return: JSON with all of the news based on user's most recent sentiment
  - Output: Shows JSON of news
   */
  static Future<dynamic> getNewsHeadlinesSentiBased() async {
    await _initializeFirebase();
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: "getAllNewsBasedOnMostRecentSentiment");
    dynamic resp = await callable.call();
    print("Resp");
    print(resp.data);
    return resp.data;
  }

  /* Send user data sentiment to the backend
  - Parameters: todaySentiment (int between 1-10), description (string)
  - Return: Void
  - Output: {error: [error], success: [success], sentiment: [sentiment], description: [description} printed in console
   */
  static Future<void> sendUserDaySentimentData(
      int todaySentiment, String description) async {
    APICall._initializeFirebase();
    DateTime current = DateTime.now();
    DateTime dayStart = new DateTime(current.year, current.month, current.day);
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: "sendUserDaySentimentData");
    dynamic resp = await callable.call(<String, dynamic>{
      "todaySentiment": todaySentiment,
      "description": description,
      "userDate": dayStart.toString()
    });
    print("Resp");
    print(resp.data);
  }

  /* Get all of user's sentiment from the backend
  - Parameters: None
  - Return: JSON with the user sentiment data
  - Output: Returns JSON of the user data in form of JSON
   */
  static Future<dynamic> getUserDaySentimentsData() async {
    APICall._initializeFirebase();
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: "getUserDaySentiments");
    dynamic resp = await callable.call();
    print("Resp");
    print(resp.data);
  }

  /*Will delete all of a user's sentiment data */
  static Future<dynamic> deleteUserDaySentimentsData() async {
    APICall._initializeFirebase();
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: "deleteUserDaySentiments");
    dynamic resp = await callable.call();
    print("Resp");
    print(resp.data);
  }

  /* Send feedback to database about the application.
  - Parameters: subject (string), message (string)
  - Output: {msg: Feedback sent!, subject: [subject], message: [message]} printed in console
   */
  static Future<void> sendUserFeedback(String subject, String message) async {
    await _initializeFirebase();
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "sendFeedback");
    dynamic resp = await callable
        .call(<String, String>{"subject": subject, "message": message});
    print("Resp");
    print(resp.data);
  }
}

/***************************Authentication Related Function Calls************************************************/

class Authentication {
  //send email authentication along with user wanted name.
  static Future<dynamic> emailAuthenticationAndAddDisplayName(
      String userAuthCodeInput, String name) async {
    await APICall._initializeFirebase();
    int userAuthCodeInputInt = int.parse(userAuthCodeInput);

    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: "verifyEmailAuthCodeAndAddDisplayName");
    dynamic resp = await callable.call(<String, dynamic>{
      "userAuthCodeInput": userAuthCodeInputInt,
      "name": name
    });
    print("Resp");
    print(resp.data);

    return resp.data;
  }

  //resend email authentication if user lost email or if email wasnt received. Currently only for sign up
  static Future<void> sendEmailAuthenticationEmail(bool isWelcome) async {
    await APICall._initializeFirebase();
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: "sendEmailAuthenticationEmail");
    dynamic resp = await callable.call(<String, bool>{"isWelcome": isWelcome});
    print("Resp");
    print(resp.data);
  }

  //Two functions below are for password reset
  static Future<void> sendResetPasswordAuthenticationEmail(String email) async {
    await APICall._initializeFirebase();
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: "sendResetPasswordAuthenticationEmail");
    dynamic resp = await callable.call(<String, dynamic>{"email": email});
    print("Resp");
    print(resp.data);
  }

  static Future<dynamic> verifyEmailAuthCodeAndResetPassword(
      String userAuthCodeInput, String email, String newPassword) async {
    await APICall._initializeFirebase();
    int userAuthCodeInputInt = int.parse(userAuthCodeInput);
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: "verifyEmailAuthCodeAndResetPassword");
    dynamic resp = await callable.call(<String, dynamic>{
      "userAuthCodeInput": userAuthCodeInputInt,
      "email": email,
      "newPassword": newPassword
    });
    print("Resp");
    print(resp.data);
    return resp.data;
  }

  /*Google Sign in */
  static Future<String> signInWithGoogle() async {
    await APICall._initializeFirebase();
    final FirebaseAuth mAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await mAuth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = mAuth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }
    return null;
  }
}
