import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/models/message.dart';

class Room {
  final int chatId;
  final dynamic members;
  Message message;
  Room({
    required this.chatId,
    required this.members,
    required this.message,
  });

  factory Room.fromDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Room(
      chatId: data['chatRoomId'] ?? 0,
      members: List<String>.from(
        data['members'] ?? [],
      ),
      message: Message.fromDocumentSnapshot(snapshot),
    );
  }
}
