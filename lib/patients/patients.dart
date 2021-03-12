import 'dart:async';

import 'package:epilappsy_web/data/patient.dart';
import 'package:epilappsy_web/data/survey.dart';
import 'package:epilappsy_web/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'patient_item.dart';

class Patients extends StatefulWidget {
  const Patients(this.surveys, this.patients, {Key key}) : super(key: key);
  final List<Survey> surveys;
  final List<Patient> patients;

  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  StreamSubscription stream;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    stream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.patients.isEmpty
        ? Center(
            child: Text("No patients to show"),
          )
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Patient Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Default Survey",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, _) => Divider(),
                  itemCount: widget.patients.length,
                  itemBuilder: (context, index) =>
                      PatientItem(widget.patients[index], widget.surveys),
                ),
              ),
            ],
          );
  }
}
