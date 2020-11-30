import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:pos_it/creators.dart';

class ProvideFeedbackPage extends StatefulWidget {
  @override
  _ProvideFeedbackPage createState() => new _ProvideFeedbackPage();
}

class _ProvideFeedbackPage extends State<ProvideFeedbackPage> {
  @override

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff131D47),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Title(),

            //First Name
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 10, 10),
                  child: Text("First Name",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Color(0xffffffff), fontSize: 20)),
                ),
                Align(
                  alignment: Alignment.topLeft,
                ),
              ]
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: TextField(
                controller: myController,
                style:
                  new TextStyle(fontSize: 22.0, color: Color(0xFF000000)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter',
                  contentPadding: const EdgeInsets.only(
                      left: 8.0, bottom: 8.0, top: 8.0, right: 8),
                ),
              ),
            ),


            //Last Name
            Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 10, 10),
                    child: Text("Last Name",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Color(0xffffffff), fontSize: 20)),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                  ),
                ]
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: TextField(
                style:
                  new TextStyle(fontSize: 22.0, color: Color(0xFF000000)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter',
                  contentPadding: const EdgeInsets.only(
                      left: 8.0, bottom: 8.0, top: 8.0, right: 8),
                ),
              ),
            ),

            //Email Address
            Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 10, 10),
                    child: Text("Email Address",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Color(0xffffffff), fontSize: 20)),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                  ),
                ]
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: TextField(
                style:
                  new TextStyle(fontSize: 22.0, color: Color(0xFF000000)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter',
                  contentPadding: const EdgeInsets.only(
                      left: 8.0, bottom: 8.0, top: 8.0, right: 8),
                ),
              ),
            ),

            //Subject
            Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 10, 10),
                    child: Text("Subject",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Color(0xffffffff), fontSize: 20)),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                  ),
                ]
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: TextField(
                style:
                  new TextStyle(fontSize: 22.0, color: Color(0xFF000000)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter',
                  contentPadding: const EdgeInsets.only(
                      left: 8.0, bottom: 8.0, top: 8.0, right: 8),
                ),
              ),
            ),

            //Message
            Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 10, 10),
                    child: Text("Message",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Color(0xffffffff), fontSize: 20)),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                  ),
                ]
            ),
            Container(
              //margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
              height: 200,
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: TextField(
                maxLines: null,
                style:
                  new TextStyle(fontSize: 22.0, color: Color(0xFF000000)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  isDense: true,
                  fillColor: Colors.white,
                  hintText: 'Enter',
                  contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 100.0),
                ),
              ),
            ),


            //Submit Button
            ButtonTheme(
                minWidth: 200,
                height: 50,
                child: FlatButton(
                  color: Color(0xffabd0a8),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreatorsPage()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Text("Submit",
                      style: TextStyle(
                          color: Color(0xff000080), fontSize: 20)),
                )),

            FloatingActionButton(
              // When the user presses the button, show an alert dialog containing the
              // text that the user has entered into the text field.
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the user has entered by using the
                      // TextEditingController.
                      content: Text(myController.text),
                    );
                  },
                );
              },
              tooltip: 'Show me the value!',
              child: Icon(Icons.text_fields),
            ),







          ],
        ),
      ),
    );
  }
}

class Title extends StatefulWidget {
  @override
  _Title createState() => _Title();
}

class _Title extends State<Title> {
  void goToSettings() {} //Go back to settings.dart

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 30, 15, 15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30,
                  semanticLabel: 'Account profile picture',
                ),
              ]),
          Align(
            alignment: Alignment.topRight,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding (
              padding: EdgeInsets.all(20),
              child: Text("Provide Feedback",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xffDCFCDD), fontWeight: FontWeight.bold, fontSize: 30)),
            ),
          ),
        ],
      ),
    );
  }
}