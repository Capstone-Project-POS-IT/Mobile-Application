import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class APICall {

  //initialize the firebase if not initialized
  static Future<bool> initializeFirebase() async {
    if (Firebase.apps.length == 0) {
      await Firebase.initializeApp();
    }
    return true;
  }

  //test the API ... prints API SUCCEEEDED if API connection works
  static Future<void> testAPI() async {
    await initializeFirebase();
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

  //Get a randomly chosen quote {author:____,text:____}
  static Future<List<String>> getInspirationalQuote() async {
    await initializeFirebase();
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
        functionName: 'randomChosenInspirationalQuote'
    );
    var resp = await callable.call();
    print(resp.data);
  }

}