import 'dart:io';

//Views
import './calendar.dart';
import './news.dart';


import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MaterialApp(
    home: MyApp(),
    ),
  );
  //runApp(MyApp());

  //test function call
  //Firebase.initializeApp().whenComplete(() =>testAPI());
  //sleep(const Duration(seconds:2));
  //Firebase.initializeApp().whenComplete(() => testDatabase());
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes

}

//home view
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new ListTile(
                title: new Text('Calendar View'),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new CalendarView())
                  );
                },
              ),
              new ListTile(
                title: new Text('News View'),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new NewsView())
                  );
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

<<<<<<< Updated upstream
/*
//calender view
class CalendarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar View',
      home: Scaffold(
        appBar: AppBar(
            title: Text('Welcome to the Calendar View'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_alert),
                tooltip: 'Show News View',
                onPressed: () {
                  newsView(context);
                }, //put in brackets function to show news view
              ),
            ]
        ),
        body: Center(
          child: Text('test'),
=======
//home view
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new ListTile(
                title: new Text('Calendar View'),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new CalendarView())
                  );
                },
              ),
              new ListTile(
                title: new Text('News View'),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new NewsView())
                  );
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Text('Hello World'),
>>>>>>> Stashed changes
        ),
      ),
    );
  }
}

<<<<<<< Updated upstream
//News view
void newsView(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('News'),
        ),  // add a way to get back to previous page
        body: const Center(
          child: Text(
            'News View',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    },
  ));
}

*/







=======
>>>>>>> Stashed changes
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

