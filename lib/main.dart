import 'package:epilappsy_web/homepage.dart';
import 'package:epilappsy_web/login.dart';
import 'package:epilappsy_web/splash.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
  "/login": (BuildContext context) => Login(),
  "/homepage": (BuildContext context) => HomePage(),
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epilappsy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: _routes,
    );
  }
}
