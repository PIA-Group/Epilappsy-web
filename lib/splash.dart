import 'package:epilappsy_web/homepage.dart';
import 'package:epilappsy_web/login.dart';
import 'package:epilappsy_web/utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.5],
          colors: [
            Theme.of(context).primaryColorLight,
            Colors.white,
          ],
        ),
      ),
      child: StreamBuilder(
        stream: Database.userState,
        builder: (BuildContext context, AsyncSnapshot<User> snap) {
          if (snap.hasError || snap.connectionState != ConnectionState.active) {
            return SplashScreen();
          } else {
            if (snap.data != null)
              return HomePage();
            else
              return Login();
          }
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.5],
          colors: [
            Theme.of(context).primaryColorLight,
            Colors.white,
          ],
        ),
      ),
    );
  }
}

/*class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    initializeUser();
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
}*/
