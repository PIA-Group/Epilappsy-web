import 'dart:html';

import 'package:epilappsy_web/homepage.dart';
import 'package:epilappsy_web/login.dart';
import 'package:epilappsy_web/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
  "/login": (BuildContext context) => Login(),
  "/homepage": (BuildContext context) => HomePage(),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    document.addEventListener('keydown', (dynamic event) {
      if (event.code == 'Tab') {
        event.preventDefault();
      }
    });
    return MaterialApp(
      title: 'Epilappsy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: _routes,
    );
  }
}
