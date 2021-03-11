part of '../question.dart';

class TextQuestion extends Question {
  TextQuestion.fromMap(String id, Map<String, dynamic> data)
      : super(
          id: id,
          text: data["text"],
          type: "text",
          visible: data["visible"],
          tag: data["tag"],
        );
}
