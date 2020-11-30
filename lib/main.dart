import 'package:flutter/material.dart';
import 'file:///C:/Users/anton/AnthonyBaron/AU_School_Things/Capstone/Mobile-Application/lib/Authentication/AccountConfirmation.dart';
import 'package:pos_it/Authentication/Login.dart';
import 'package:pos_it/Authentication/EmailAuthentication.dart';
import 'package:pos_it/Authentication/SignUp.dart';
import 'package:pos_it/EditProfile.dart';
import 'package:pos_it/ExternalCalls.dart';
import 'package:pos_it/Profile.dart';
import 'package:pos_it/ProvideFeedback.dart';
import 'package:pos_it/calendar.dart';
import 'package:pos_it/settings.dart';
import 'package:pos_it/creators.dart';
import 'package:pos_it/home.dart';
import 'package:pos_it/news.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProvideFeedbackPage(),
    );
  }
}
