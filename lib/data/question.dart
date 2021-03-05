import 'package:flutter/material.dart';

part 'questions/checkbox_question.dart';
part 'questions/options_question.dart';
part 'questions/radio_question.dart';

class Question {
  final String id;
  String text;
  String type;
  GlobalKey key;

  Question({
    @required this.id,
    @required this.text,
    this.type = "text",
  }) {
    key = GlobalKey();
  }

  Question.fromMap(this.id, Map<String, dynamic> data)
      : assert(data != null),
        assert(data["text"] != null),
        assert(data["type"] != null),
        text = data["text"],
        type = data["type"];

  Map<String, dynamic> toMap() => {
        "text": text,
        "type": type,
      };

  static Question getQuestion(String id, Map<String, dynamic> data) {
    final String type = data["type"];
    assert(type != null);
    switch (type) {
      case "checkbox":
        return CheckboxQuestion.fromMap(id, data);
      case "radio":
        return RadioQuestion.fromMap(id, data);
      default:
        return Question.fromMap(id, data);
    }
  }
}
