import 'package:flutter/material.dart';

class Patient {
  final String id;
  final String name;
  String surveyID;

  Patient({@required this.id, @required this.name, @required this.surveyID});

  Patient.fromMap(String id, Map<String, dynamic> data)
      : this.id = id,
        this.name = data["name"] ?? "Jon Doe",
        this.surveyID = data["default survey"];
}
