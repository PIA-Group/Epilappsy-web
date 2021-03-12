import 'dart:async';

import 'package:epilappsy_web/data/patient.dart';
import 'package:epilappsy_web/data/survey.dart';
import 'package:epilappsy_web/patients/patients.dart';
import 'package:epilappsy_web/surveys/surveys_list/surveys_list.dart';
import 'package:epilappsy_web/ui/topbar.dart';
import 'package:epilappsy_web/utils/database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Survey> _surveys = [];
  List<Patient> _patients = [];
  StreamSubscription _streamSurveys;
  StreamSubscription _streamPatients;
  final List<Tab> _tabs = [
    Tab(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.article),
          SizedBox(width: 12),
          Text("Surveys"),
        ],
      ),
    ),
    Tab(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people),
          SizedBox(width: 12),
          Text("People"),
        ],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();

    _streamSurveys = Database.mySurveys().listen((List<Survey> surveys) {
      _surveys = surveys;
      if (mounted) {
        setState(() {});
      }
    });
    _streamPatients = Database.getPatients().listen((List<Patient> patients) {
      _patients = patients;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _streamSurveys?.cancel();
    _streamPatients?.cancel();
    super.dispose();
  }

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
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            tabs: _tabs,
                            labelColor: Colors.black,
                            indicator: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(50), // Creates border
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child: TabBarView(
                              children: [
                                SurveysList(_surveys),
                                Patients(_surveys, _patients),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
