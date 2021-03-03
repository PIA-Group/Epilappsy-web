import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    //initializeUser();
  }

  Future initializeUser() async {
    await Firebase.initializeApp();
    navigateUser();
  }

  navigateUser() async {
    // checking whether user already loggedIn or not
    if (_auth.currentUser != null) {
      Navigator.of(context).pushReplacementNamed("/homepage");
    } else {
      Navigator.of(context).pushReplacementNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("Design Your splash screen"),
        ),
      ),
    );
  }
}
