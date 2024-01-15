import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? id;
  final int userId;
  final String text;
  final Timestamp timestamp;

  Message({
    this.id,
    required this.text,
    required this.timestamp,
    required this.userId,
  });
  factory Message.fromDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Message(
      id: snapshot.id,
      userId: data['userId'] ?? 0,
      timestamp: data['timestamp'] ?? Timestamp.now(),
      text: data['text'] ?? '',
    );
  }
}
