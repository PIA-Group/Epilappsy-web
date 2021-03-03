class Question {
  final String id;
  String text;

  Question.fromMap(this.id, Map<String, dynamic> data) : text = data["text"];
}
