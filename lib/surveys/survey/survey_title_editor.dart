import 'package:epilappsy_web/data/survey.dart';
import 'package:epilappsy_web/utils/database.dart';
import 'package:flutter/material.dart';

class SurveyTitleEditor extends StatefulWidget {
  const SurveyTitleEditor(this.survey, {Key key}) : super(key: key);
  final Survey survey;

  @override
  _SurveyTitleEditorState createState() => _SurveyTitleEditorState();
}

class _SurveyTitleEditorState extends State<SurveyTitleEditor> {
  TextEditingController _controller;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.survey.title);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) _updateTitle();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        decoration: InputDecoration(
          hintText: "Write a title",
          contentPadding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 16,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey[200],
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(20.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).primaryColorLight,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(20.0),
            ),
          ),
        ),
        controller: _controller,
        focusNode: _focusNode,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.center,
      );

  void _updateTitle() {
    final String title = _controller.text.trim();
    if (title.isNotEmpty) {
      if (title != widget.survey.title) {
        Database.setSurveyTitle(widget.survey.id, title);
      }
    } else {
      _controller.text = widget.survey.title;
    }
  }
}
