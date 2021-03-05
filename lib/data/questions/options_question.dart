part of '../question.dart';

class OptionsQuestion extends Question {
  List<String> options = [];

  OptionsQuestion(
      {@required id,
      @required String text,
      @required String type,
      this.options})
      : super(id: id, text: text, type: type);

  void addOption(String option) {
    print(option);
    options.add(option);
  }

  void removeOption(int index) {
    options.removeAt(index);
  }

  Map<String, dynamic> toMap() => {
        "text": text,
        "type": type,
        "options": options,
      };
}
