part of '../question.dart';

class OptionsQuestion extends Question {
  List<String> options = [];

  OptionsQuestion({
    @required id,
    @required String text,
    @required String type,
    List<dynamic> options,
    Map<String, dynamic> visible,
    String tag,
  }) : super(
          id: id,
          text: text,
          type: type,
          visible: visible,
          tag: tag,
        ) {
    this.options = List<String>.from(options ?? []);
  }

  void addOption(String option) {
    options.add(option);
  }

  void removeOption(int index) {
    options.removeAt(index);
  }

  Map<String, dynamic> toMap() => {
        "text": text,
        "type": type,
        "options": options,
        "visible": visible.isNotEmpty ? visible : null,
        "tag": tag,
      };
}
