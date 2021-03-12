part of '../question.dart';

class NumberQuestion extends Question {
  NumberQuestion.fromMap(String id, Map<String, dynamic> data)
      : super(
          id: id,
          text: data["text"],
          type: "number",
          visible: data["visible"],
          tag: data["tag"],
        );
}
