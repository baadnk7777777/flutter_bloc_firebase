import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/models/message.dart';

abstract class FirebaseNetwork {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<QuerySnapshot> getDocument(String collectionPath);
  Future<List<Message>> getAllMessages();
}
