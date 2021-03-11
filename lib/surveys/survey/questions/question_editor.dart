import 'package:epilappsy_web/data/question.dart';
import 'package:epilappsy_web/surveys/survey/questions/options_editor.dart';
import 'package:epilappsy_web/surveys/survey/survey_editor.dart';
import 'package:epilappsy_web/surveys/survey/visibility_editor.dart';
import 'package:epilappsy_web/ui/my_icon_button.dart';
import 'package:flutter/material.dart';

class QuestionEditor extends StatefulWidget {
  const QuestionEditor(this.question, {@required this.questions, Key key})
      : super(key: key);
  final Question question;
  final List<Question> questions;

  @override
  _QuestionEditorState createState() => _QuestionEditorState();
}

class _QuestionEditorState extends State<QuestionEditor> {
  TextEditingController _controller;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.question.text);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) _updateText();
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              questionTypes[widget.question.type].label,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Write a question",
              contentPadding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey[300],
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
            style: TextStyle(fontSize: 18),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600,
            ),
            child: _getQuestionEditor(),
          ),
          SizedBox(height: 4),
          VisibilityEditor(
            question: widget.question,
            questions: widget.questions,
          ),
        ],
      );

  void _updateText() {
    final String text = _controller.text.trim();
    if (text.isNotEmpty) {
      if (text != widget.question.text) {
        widget.question.text = text;
      }
    } else {
      _controller.text = widget.question.text;
    }
  }

  Widget _getQuestionEditor() {
    if (widget.question is OptionsQuestion)
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 400,
        ),
        child: OptionsEditor(widget.question),
      );
    else
      return Container();
  }
}
