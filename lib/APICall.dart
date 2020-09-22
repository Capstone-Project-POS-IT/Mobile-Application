import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class APICall {
  //initialize the firebase if not initialized
  static Future<bool> initializeFirebase() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    return true;
  }

  //test the API
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

}
