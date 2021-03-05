import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilappsy_web/data/question.dart';
import 'package:epilappsy_web/data/survey.dart';
import 'package:epilappsy_web/data/survey_questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Stream;

typedef OnLogin = Function(UserCredential user);
typedef OnError = Function(dynamic error);

class Database {
  static String userID;

  static Future<UserCredential> login(String email, String password,
          {OnLogin onLogin, OnError onError}) async =>
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((UserCredential user) {
        if (onLogin != null) onLogin(user);
        return user;
      }).catchError(onError);

  static Future<void> signOut() async => await FirebaseAuth.instance.signOut();

  static Future<String> getName() async => ((await FirebaseFirestore.instance
              .collection("doctors")
              .doc(userID)
              .get())
          ?.data() ??
      {})["name"];

  static Stream<User> get userState async* {
    await for (User user in FirebaseAuth.instance.authStateChanges()) {
      if (user != null && await isValidUser(user.uid)) {
        if (userID == null && user != null) userID = user.uid;
        yield user;
      } else {
        yield null;
      }
    }
  }

  static Future<bool> isValidUser(String userID) async =>
      (await FirebaseFirestore.instance.collection("doctors").doc(userID).get())
          .exists;

  static CollectionReference get surveysReference => FirebaseFirestore.instance
      .collection("surveys-doctors")
      .doc(userID)
      .collection("surveys");

  static Stream<List<Survey>> mySurveys() =>
      surveysReference.orderBy("timestamp", descending: true).snapshots().map(
            (QuerySnapshot query) => List<Survey>.from(
              query?.docs?.map(
                    (QueryDocumentSnapshot doc) => Survey.fromMap(
                      doc.id,
                      doc.data(),
                    ),
                  ) ??
                  [],
            ),
          );

  static Future<Map<String, Question>> getSurveyQuestions(
          String surveyID) async =>
      Map.fromEntries(
        (await surveysReference.doc(surveyID).collection("questions").get())
            .docs
            .map(
              (QueryDocumentSnapshot doc) => MapEntry(
                doc.id,
                Question.getQuestion(
                  doc.id,
                  doc.data(),
                ),
              ),
            ),
      );

  static Future<Survey> newSurvey() async {
    final DocumentReference doc = await surveysReference.add(
      {
        "title": "New survey title",
        "fromTemplate": false,
        "order": [],
        "timestamp": DateTime.now(),
      },
    );
    return Survey.fromMap(doc.id, (await doc.get()).data());
  }

  static Future<void> setSurveyTitle(String surveyID, String title) async =>
      await surveysReference.doc(surveyID).update({"title": title});

  static Future<Question> newQuestion(SurveyQuestions survey,
      {String type = "text", @required int index}) async {
    final DocumentReference documentReference = surveysReference.doc(survey.id);

    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      final Map<String, dynamic> data = {"text": "", "type": type};
      final String questionID =
          (await documentReference.collection("questions").add(
                    data,
                  ))
              .id;

      final List<String> order = survey.order.toList();
      order.insert(index, questionID);

      transaction.update(documentReference, {"order": order});
      return Question.getQuestion(questionID, data);
    }).catchError((error) {
      print(error);
    });
  }

  static Future<void> updateQuestions(SurveyQuestions survey) async {
    await surveysReference.doc(survey.id).update({"order": survey.order});
    for (Question question in survey.questions) {
      await surveysReference
          .doc(survey.id)
          .collection("questions")
          .doc(question.id)
          .update(question.toMap());
    }
  }

  static Future<void> deleteSurvey(String surveyID) async =>
      await surveysReference.doc(surveyID).delete();

  static Future<void> deleteQuestion(String surveyID, String questionID) async {
    final DocumentReference doc = surveysReference.doc(surveyID);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(doc, {
        "order": FieldValue.arrayRemove([questionID])
      });
      transaction.delete(doc.collection("questions").doc(questionID));
    }).catchError((error) {
      print(error);
    });
  }
}
