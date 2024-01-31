import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? id;
  final String uId;
  final int chatId;
  final String text;
  final Timestamp timestamp;

  Message({
    this.id,
    required this.text,
    required this.uId,
    required this.chatId,
    required this.timestamp,
  });
  static final Timestamp initialTimestamp =
      Timestamp.fromMillisecondsSinceEpoch(0);

  factory Message.fromDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Message(
      id: snapshot.id,
      uId: data['uId'] ?? '',
      chatId: data['chatId'] ?? 0,
      timestamp: data['timestamp'] ?? Timestamp.now(),
      text: data['text'] ?? '',
    );
  }
}
