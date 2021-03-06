import 'package:epilappsy_web/data/question.dart';
import 'package:epilappsy_web/data/survey.dart';
import 'package:flutter/material.dart';

class SurveyQuestions with ChangeNotifier {
  String id;
  Map<String, Question> _questions;
  List<String> order;
  Survey parent;

  SurveyQuestions(
      {@required this.id,
      @required questions,
      @required this.order,
      this.parent}) {
    _questions = questions;
  }

  List<Question> get questions => List<Question>.from(
        order.map(
          (String questionID) => _questions[questionID],
        ),
      );

  void addQuestion(int index, Question question) {
    order.insert(index, question.id);
    _questions[question.id] = question;
    notifyListeners();
  }

  void removeQuestion(String questionID) {
    order.remove(questionID);
    _questions.remove(questionID);
    notifyListeners();
  }

  void updateIndex(String questionID, int currentIndex, int delta) {
    this.order.removeAt(currentIndex);
    if (delta > 1) currentIndex--;
    this.order.insert(currentIndex + delta, questionID);
    notifyListeners();
  }
}
