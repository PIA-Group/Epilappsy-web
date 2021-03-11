import 'package:flutter/material.dart';

part 'questions/checkbox_question.dart';
part 'questions/options_question.dart';
part 'questions/radio_question.dart';
part 'questions/toggle_question.dart';
part 'questions/text_question.dart';
part 'questions/number_question.dart';

abstract class Question {
  final String id;
  String text;
  String type;
  String tag;
  Map<String, List<String>> visible;

  Question({
    @required this.id,
    @required this.text,
    this.type = "text",
    Map<String, dynamic> visible,
    this.tag,
  }) {
    this.visible = Map<String, List<String>>.from(visible?.map(
          (key, value) => MapEntry(
            key,
            List<String>.from(value),
          ),
        ) ??
        {});
  }

  Map<String, dynamic> toMap() => {
        "text": text,
        "type": type,
        "visible": visible.isNotEmpty ? visible : null,
        "tag": tag,
      };

  static Question getQuestion(String id, Map<String, dynamic> data) {
    final String type = data["type"];
    assert(type != null);
    switch (type) {
      case "checkbox":
        return CheckboxQuestion.fromMap(id, data);
      case "radio":
        return RadioQuestion.fromMap(id, data);
      case "toggle":
        return ToggleQuestion.fromMap(id, data);
      case "number":
        return NumberQuestion.fromMap(id, data);
      default:
        return TextQuestion.fromMap(id, data);
    }
  }
}
