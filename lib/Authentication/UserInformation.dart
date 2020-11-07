/*Class holds all of user information and preferences*/
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInformation {
  static User _user; //will be the Firebase User
  //Data to be stored of the user

  /*Initiation functions*/
  static void initiateFirebaseUser(User userCreate) {
    _user = userCreate;
  }

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
    }
  }


}
