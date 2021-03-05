import 'package:epilappsy_web/data/question.dart';
import 'package:flutter/material.dart';

class SurveyQuestions {
  String id;
  Map<String, Question> _questions;
  List<String> order;

  SurveyQuestions(
      {@required this.id, @required questions, @required this.order}) {
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
  }

  void removeQuestion(String questionID) {
    order.remove(questionID);
    _questions.remove(questionID);
  }

  void updateIndex(String questionID, int currentIndex, int delta) {
    this.order.removeAt(currentIndex);
    if (delta > 1) currentIndex--;
    this.order.insert(currentIndex + delta, questionID);
  }
}
