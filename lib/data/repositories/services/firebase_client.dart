import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/models/message.dart';

class FirebaseClient {
  final CollectionReference _messageCollection =
      FirebaseFirestore.instance.collection('messages');

  Future<void> sentMessage(String message, int userId) async {
    try {
      await _messageCollection.add({
        'userId': userId,
        'text': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Message>> getAllMessages() async {
    try {
      QuerySnapshot querySnapshot = await _messageCollection.get();
      List<Message> messages = querySnapshot.docs
          .map((e) => Message.fromDocumentSnapshot(e))
          .toList();
      return messages;
    } catch (e) {
      return [];
    }
  }
}
