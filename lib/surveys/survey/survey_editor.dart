import 'package:epilappsy_web/data/question.dart';
import 'package:epilappsy_web/data/survey_questions.dart';
import 'package:epilappsy_web/surveys/survey/questions/question_editor.dart';
import 'package:epilappsy_web/ui/my_icon_button.dart';
import 'package:epilappsy_web/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'question_divider.dart';
part 'question_type_selector.dart';

class SurveyEditor extends StatefulWidget {
  const SurveyEditor(this.survey, {Key key}) : super(key: key);

  final SurveyQuestions survey;

  @override
  _SurveyEditorState createState() => _SurveyEditorState();
}

class _SurveyEditorState extends State<SurveyEditor> {
  int _currentIndex = -1;
  QuestionTypeSelector _questionTypeSelector;

  final Map<String, QuestionEditor> _questionEditors = {};

  @override
  void initState() {
    super.initState();
    _questionTypeSelector = QuestionTypeSelector(_newQuestion);
    widget.survey.questions.forEach(
      (Question question) => _questionEditors[question.id] = QuestionEditor(
        question,
        key: GlobalKey(),
      ),
    );
  }

  @override
  void dispose() {
    Database.updateQuestions(widget.survey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Survey Questions:",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        Expanded(
          child: (widget.survey.questions.isEmpty
              ? Align(
                  alignment: Alignment.topCenter,
                  child: _getQuestionDivider(0, visible: true),
                )
              : ListView.builder(
                  itemCount: widget.survey.questions.length,
                  itemBuilder: (context, index) {
                    final Question question = widget.survey.questions[index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        (index == 0)
                            ? _getQuestionDivider(0,
                                visible: (_currentIndex == 0))
                            : Container(),
                        _getQuestionItem(question, index),
                        _getQuestionDivider(
                          index + 1,
                          visible:
                              (index == widget.survey.questions.length - 1) ||
                                  (index == _currentIndex - 1),
                        ),
                      ],
                    );
                  },
                )),
        ),
      ],
    );
  }

  Future<void> _newQuestion(String type) async {
    final int index = _currentIndex;
    final Question question =
        await Database.newQuestion(widget.survey, type: type, index: index);
    setState(() {
      _currentIndex = -1;
      _questionEditors[question.id] = QuestionEditor(
        question,
        key: GlobalKey(),
      );
      widget.survey.addQuestion(index, question);
    });
  }

  Widget _getQuestionItem(Question question, int index) {
    bool _showOptions = false;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 80),
      child: StatefulBuilder(
        builder: (context, _setState) => MouseRegion(
          onEnter: (_) {
            _setState(() {
              _showOptions = true;
            });
          },
          onExit: (_) {
            _setState(() {
              _showOptions = false;
            });
          },
          child: Row(
            children: [
              Expanded(
                child: _questionEditors[question.id],
              ),
              _showOptions
                  ? Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MyIconButton(
                                icon: Icon(Icons.keyboard_arrow_up),
                                onPressed: () => _changeQuestionIndex(
                                    question.id, index,
                                    up: true),
                              ),
                              MyIconButton(
                                icon: Icon(Icons.keyboard_arrow_down),
                                onPressed: () => _changeQuestionIndex(
                                    question.id, index,
                                    up: false),
                              ),
                            ],
                          ),
                          MyIconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => _deleteQuestion(question.id),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(width: 100),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _changeQuestionIndex(String questionID, int index,
      {@required bool up}) async {
    final int delta = up ? -1 : 1;
    if (index + delta >= 0 && index + delta < widget.survey.order.length) {
      setState(() {
        widget.survey.updateIndex(questionID, index, delta);
      });
    }
  }

  Future<void> _deleteQuestion(String questionID) async {
    setState(() {
      widget.survey.removeQuestion(questionID);
      _questionEditors.remove(questionID);
    });
    await Database.deleteQuestion(widget.survey.id, questionID);
  }

  Widget _getQuestionDivider(int index, {bool visible = false}) => Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QuestionDivider(
              index: index,
              newQuestion: _toggleIndex,
              visible: visible,
            ),
            SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: double.infinity,
              height: _currentIndex == index ? 100 : 0,
              child: (_currentIndex == index)
                  ? _questionTypeSelector
                  : Container(),
            ),
          ],
        ),
      );

  void _toggleIndex(int index) {
    setState(() {
      if (_currentIndex == index) {
        _currentIndex = -1;
      } else {
        _currentIndex = index;
      }
    });
  }
}
