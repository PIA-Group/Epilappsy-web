part of '../question.dart';

class CheckboxQuestion extends OptionsQuestion {
  CheckboxQuestion(
      {@required id, @required String text, List<String> options = const []})
      : super(
          id: id,
          text: text,
          type: "checkbox",
          options: options,
        );

  CheckboxQuestion.fromMap(String id, Map<String, dynamic> data)
      : super(
          id: id,
          text: data["text"],
          type: "checkbox",
          options: List<String>.from(
            data["options"] ?? [],
          ),
        );
}
