part of '../question.dart';

class ToggleQuestion extends OptionsQuestion {
  ToggleQuestion.fromMap(String id, Map<String, dynamic> data)
      : super(
          id: id,
          text: data["text"],
          type: "toggle",
          options: data["options"],
          visible: data["visible"],
          tag: data["tag"],
        );
}
