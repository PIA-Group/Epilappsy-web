import 'package:epilappsy_web/surveys/surveys_list/surveys_list.dart';
import 'package:epilappsy_web/ui/topbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 32, right: 32, top: 32),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 1440,
                  ),
                  width: double.infinity,
                  height: 56,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: TopBar(),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding:
                    EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 16),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 1440,
                    ),
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.all(24),
                    child: SurveysList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
