import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());

  //test function call
  Firebase.initializeApp().whenComplete(() =>testAPI());
  sleep(const Duration(seconds:2));
  Firebase.initializeApp().whenComplete(() => testDatabase());


}
//*****************************************Test Start **********************************************************/
Future<void> testAPI() async {

  final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    functionName: 'testDemo',
  );
  dynamic resp = await callable.call(); //one time call function with no params
  //function call with parameters
  // dynamic resp = await callable.call(
  //   <String, dynamic>{
  //     'response': 'ping',
  //   },
  // );
  if(resp.data['msg']=="Hello from Firebase!"){
    print("API SUCCEEEDED!!!!!!!!!!!!!!!!!");
  }
  else{
    print("API failed :(");
  }
}

Future<void> testDatabase() async {
  await Firebase.initializeApp();
  FirebaseDatabase.instance.reference().child('AppName')
      .set({
    'title': 'POS.IT',
    'created_at': DateTime.now().millisecondsSinceEpoch
  });

  var firebaseRef = FirebaseDatabase().reference().child('AppName');

  await firebaseRef.once().then((DataSnapshot snapshot) {
    var data = snapshot.value;
    if(data['title']=='POS.IT'&&data['created_at']>0){
      print("DATABASE SUCEEDED!!!!!!!!!!!!!!!!!!!!!!!!!");
      firebaseRef.remove();
    }
  });
}



/*************************************************Test End**********************************************************/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to POS.IT!!!'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
