part of '../question.dart';

class RadioQuestion extends OptionsQuestion {
  RadioQuestion.fromMap(String id, Map<String, dynamic> data)
      : super(
          id: id,
          text: data["text"],
          type: "radio",
          options: data["options"],
          visible: data["visible"],
          tag: data["tag"],
        );
}
