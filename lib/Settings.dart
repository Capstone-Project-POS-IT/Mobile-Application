import 'dart:io';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsView createState() => new _SettingsView();
}

class _SettingsView extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Settings'),
      ),
    );
  }
}