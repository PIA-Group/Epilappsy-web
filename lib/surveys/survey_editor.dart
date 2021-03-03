import 'package:epilappsy_web/data/survey.dart';
import 'package:flutter/material.dart';

class SurveyEditor extends StatefulWidget {
  const SurveyEditor(this.survey, {Key key}) : super(key: key);

  final Survey survey;

  @override
  _SurveyEditorState createState() => _SurveyEditorState();
}

class _SurveyEditorState extends State<SurveyEditor> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.survey.name);
  }
}
