import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/models/message.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/models/services_request.dart';

abstract class FirebaseNetwork {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<QuerySnapshot> getDocument(String collectionPath);
  Future<List<Message>> getAllMessages();
  Future<void> addRequest(
      String issue, String uId, int rating, String serviceType, String status);
  Future<List<ServicesRequest>> getAllServicesRequest();
  Future<void> sentMessage(String message, String uId, int chatId);
}
