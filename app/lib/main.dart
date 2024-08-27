import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Nav.dart';
//Google Map API key to be updated in AndroidManifest.xml and AppDelegate.swift


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp>{

  final Future<FirebaseApp> _fbapp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      title: "bottom navigation bar",
      home: Nav(),
    );  
  }
}