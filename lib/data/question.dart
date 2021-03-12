import 'package:flutter/material.dart';

part 'questions/checkbox_question.dart';
part 'questions/options_question.dart';
part 'questions/radio_question.dart';
part 'questions/toggle_question.dart';
part 'questions/text_question.dart';
part 'questions/number_question.dart';

abstract class Question extends ChangeNotifier {
  final String id;
  String _text;
  String type;
  String tag;
  Map<String, List<String>> visible;

  Question({
    @required this.id,
    @required text,
    this.type = "text",
    Map<String, dynamic> visible,
    this.tag,
  }) {
    this._text = text;
    this.visible = Map<String, List<String>>.from(visible?.map(
          (key, value) => MapEntry(
            key,
            List<String>.from(value),
          ),
        ) ??
        <String, List<String>>{});
  }

  String get text => _text;

  set text(String value) {
    _text = value;
    notifyListeners();
  }

  Map<String, dynamic> toMap() => {
        "text": _text,
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
