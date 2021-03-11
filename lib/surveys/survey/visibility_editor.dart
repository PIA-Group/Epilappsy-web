import 'package:epilappsy_web/data/question.dart';
import 'package:epilappsy_web/ui/my_icon_button.dart';
import 'package:epilappsy_web/ui/my_text_form_field.dart';
import 'package:flutter/material.dart';

class VisibilityEditor extends StatefulWidget {
  const VisibilityEditor(
      {@required this.question, @required this.questions, Key key})
      : super(key: key);
  final Question question;
  final List<Question> questions;

  @override
  _VisibilityEditorState createState() => _VisibilityEditorState();
}

class _VisibilityEditorState extends State<VisibilityEditor> {
  List<Map<String, dynamic>> _conditions = [];
  List<Question> questions = [];
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  TextEditingController questionID;
  FocusNode focusNode = FocusNode();
  bool _visibilityEditor;

  @override
  void initState() {
    super.initState();
    _setQuestions(widget.questions);
    questionID = TextEditingController(text: questions?.first?.id);
    _conditions = List<Map<String, dynamic>>.from(
      widget.question.visible.entries
          .where((MapEntry entry) => questions.contains(entry.key))
          .map((MapEntry<String, List<String>> condition) {
        final TextEditingController controller = TextEditingController(
          text: condition.value.join("; "),
        );
        final TextEditingController questionID = TextEditingController(
          text: condition.key,
        );
        final FocusNode focusNode = FocusNode()
          ..addListener(
            () => _updateText(controller, condition.value.first),
          );
        return {
          "controller": controller,
          "focus": focusNode,
          "questionID": questionID,
        };
      }),
    );
    _visibilityEditor = _conditions.isNotEmpty;
  }

  void _updateText(TextEditingController controller, String defaultText) {
    final String text = controller.text.trim();
    if (text.isEmpty) {
      controller.text = defaultText;
    }
  }

  @override
  void dispose() {
    widget.question.visible = Map<String, List<String>>.fromEntries(
      _conditions.map(
        (Map<String, dynamic> options) {
          final TextEditingController controller = options["controller"];
          final TextEditingController questionID = options["questionID"];
          return MapEntry(
            questionID.text,
            controller.text
                .split(";")
                .map((String condition) => condition.trim())
                .toList(),
          );
        },
      ),
    );
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VisibilityEditor oldWidget) {
    if (oldWidget.questions.length != this.questions.length)
      _setQuestions(this.questions);
    super.didUpdateWidget(oldWidget);
  }

  void _setQuestions(List<Question> questions) {
    this.questions = widget.questions
        .where((Question question) => question.id != widget.question.id)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Form newCondition = Form(
      key: key,
      child: Row(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => ConstrainedBox(
                constraints: constraints,
                child: DropdownButton<String>(
                  value: questionID.text,
                  onChanged: (String newQuestionID) {
                    setState(() {
                      questionID.text = newQuestionID;
                    });
                  },
                  items: questions
                      .map<DropdownMenuItem<String>>(
                        (Question question) => DropdownMenuItem<String>(
                          value: question.id,
                          child: SizedBox(
                            width: constraints.maxWidth - 24,
                            child: Text(
                              question.text,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: MyTextFormField(
              hintText: "Write a condition",
              validator: (String text) {
                if (text.trim().isEmpty) return "Condition can't be empty";
                return null;
              },
              onFieldSubmitted: (String text) {
                if (key.currentState.validate()) {
                  controller.clear();
                  _newCondition(questionID.text, text.trim());
                }
              },
              controller: controller,
              focusNode: focusNode,
            ),
          ),
        ],
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyIconButton(
              onPressed: () => setState(() {
                _visibilityEditor = !_visibilityEditor;
              }),
              icon: Icon(
                Icons.visibility,
                color: _conditions.isEmpty ? Colors.green : Colors.orange,
              ),
            ),
            SizedBox(width: 4),
            Text(_conditions.isEmpty ? "Always visible" : "Visible if:")
          ],
        ),
        _visibilityEditor
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          "Question",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Condition: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '(multiple conditions separeted by '),
                                    TextSpan(
                                      text: 'semicolon ;',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    TextSpan(text: ' )'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 32),
                    ],
                  ),
                  SizedBox(height: 8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List<Widget>.from(
                      _conditions.map(
                        (Map<String, dynamic> condition) =>
                            _conditionBuilder(condition),
                      ),
                    )..add(newCondition),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  Widget _conditionBuilder(Map<String, dynamic> condition) {
    final TextEditingController controller = condition["controller"];
    final FocusNode focusNode = condition["focus"];
    final TextEditingController questionID = condition["questionID"];
    return Row(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) => ConstrainedBox(
              constraints: constraints,
              child: DropdownButton<String>(
                value: questionID.text,
                onChanged: (String newQuestionID) {
                  setState(() {
                    questionID.text = newQuestionID;
                  });
                },
                items: questions
                    .map<DropdownMenuItem<String>>(
                        (Question question) => DropdownMenuItem<String>(
                              value: question.id,
                              child: SizedBox(
                                width: constraints.maxWidth - 24,
                                child: Text(
                                  question.text,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ))
                    .toList(),
              ),
            ),
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          flex: 2,
          child: MyTextFormField(
              controller: controller,
              focusNode: focusNode,
              hintText: "Write a condition"),
        ),
        SizedBox(width: 8),
        MyIconButton(
          icon: Icon(
            Icons.close,
            color: Colors.red[300],
            size: 20,
          ),
          onPressed: () => _deleteOption(condition),
          size: 32,
        ),
      ],
    );
  }

  void _deleteOption(Map<String, dynamic> condition) {
    setState(() {
      _conditions.remove(condition);
    });
  }

  void _newCondition(String questionID, String condition) {
    setState(() {
      _conditions.add(
        {
          "controller": TextEditingController(text: condition),
          "focus": FocusNode(),
          "questionID": TextEditingController(text: questionID),
        },
      );
    });
    focusNode.requestFocus();
  }
}
