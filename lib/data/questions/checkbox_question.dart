part of '../question.dart';

class CheckboxQuestion extends OptionsQuestion {
  CheckboxQuestion.fromMap(String id, Map<String, dynamic> data)
      : super(
          id: id,
          text: data["text"],
          type: "checkbox",
          options: data["options"],
          visible: data["visible"],
          tag: data["tag"],
        );
}
