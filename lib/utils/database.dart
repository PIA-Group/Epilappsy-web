import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilappsy_web/data/question.dart';
import 'package:epilappsy_web/data/survey.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  static Stream<List<Survey>> mySurveys() => FirebaseFirestore.instance
      .collection("surveys-doctors")
      .doc(userID)
      .collection("surveys")
      .snapshots()
      .map(
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

  static Stream<List<Question>> getSurveyQuestions(String surveyID) =>
      FirebaseFirestore.instance
          .collection("surveys-doctors")
          .doc(userID)
          .collection("surveys")
          .doc(surveyID)
          .collection("questions")
          .snapshots()
          .map(
            (QuerySnapshot query) => List<Question>.from(
              query?.docs?.map(
                    (QueryDocumentSnapshot doc) => Question.fromMap(
                      doc.id,
                      doc.data(),
                    ),
                  ) ??
                  [],
            ),
          );
}
