import 'package:cloud_firestore/cloud_firestore.dart';

class Survey {
  final String id;
  String title;
  DateTime timestamp;
  List<String> order;

  Survey.fromMap(this.id, Map<String, dynamic> data)
      : assert(id != null),
        assert(data["title"] != null),
        title = data["title"],
        order = List<String>.from(data["order"] ?? []),
        timestamp = data["timestamp"] != null
            ? (data["timestamp"] as Timestamp).toDate()
            : DateTime.now();
}
