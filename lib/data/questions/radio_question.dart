part of '../question.dart';

class RadioQuestion extends OptionsQuestion {
  RadioQuestion(
      {@required id, @required String text, List<String> options = const []})
      : super(
          id: id,
          text: text,
          type: "radio",
          options: options,
        );

  RadioQuestion.fromMap(String id, Map<String, dynamic> data)
      : super(
          id: id,
          text: data["text"],
          type: "radio",
          options: List<String>.from(
            data["options"] ?? [],
          ),
        );
}
