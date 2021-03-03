import 'package:epilappsy_web/data/question.dart';
import 'package:epilappsy_web/utils/database.dart';

class Survey {
  final String id;
  String name;
  List<String> _order;

  Survey.fromMap(this.id, Map<String, dynamic> data)
      : name = data["name"],
        _order = List<String>.from(data["order"] ?? []);

  Stream<List<Question>> get questions => Database.getSurveyQuestions(id);
}
