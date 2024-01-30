import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/models/message.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/models/services_request.dart';
import 'package:flutter_bloc_firebase_2/network/firebase_network.dart';
import 'package:flutter_bloc_firebase_2/network/impl/firebase_network_error.dart';
import 'package:flutter_bloc_firebase_2/utils/custom_logger.dart';
import 'package:uuid/uuid.dart';

class FirebaseNetworkImpl implements FirebaseNetwork {
  final CollectionReference _messageCollection =
      FirebaseFirestore.instance.collection('messages');
  final CollectionReference _servicsReqestCollection =
      FirebaseFirestore.instance.collection('Services_request');
  final Uuid uuid = const Uuid();

  @override
  Future<List<Message>> getAllMessages() async {
    try {
      QuerySnapshot querySnapshot = await _messageCollection.get();
      List<Message> messages = querySnapshot.docs
          .map((e) => Message.fromDocumentSnapshot(e))
          .toList();
      AppLogger.log('Got messages ${messages.length}',
          'FIREBASE_NETWORK_GET_ALL_MESSAGES', '✅');
      return messages;
    } catch (e) {
      AppLogger.logE(
          'Filed to Get messages $e', 'FIREBASE_NETWORK_GET_ALL_MESSAGES', '❌');
      return [];
    }
  }

  @override
  Future<QuerySnapshot> getDocument(String collectionPath) async {
    try {
      return await firebaseFirestore.collection(collectionPath).get();
    } catch (e) {
      print('Error fetching document: $e');
      throw FirebaseNetworkException('Error fetching document: $e');
    }
  }

  @override
  Future<void> addRequest(String issue, String uId, int rating,
      String serviceType, String status) async {
    try {
      await _servicsReqestCollection.add({
        'issue': issue,
        'rating': rating,
        'service_type': serviceType,
        'status': status,
        'timestamp': FieldValue.serverTimestamp(),
        'uId': uId,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  // TODO: implement firebaseFirestore
  FirebaseFirestore get firebaseFirestore => throw UnimplementedError();

  @override
  Future<List<ServicesRequest>> getAllServicesRequest() async {
    try {
      QuerySnapshot querySnapshot = await _servicsReqestCollection.get();
      List<ServicesRequest> request = querySnapshot.docs
          .map((e) => ServicesRequest.fromDocumentSnapshot(e))
          .toList();

      return request;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> sentMessage(String message, String uId, int chatId) async {
    try {
      await _messageCollection.add({
        'uId': uId,
        'chatId': chatId,
        'text': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
      AppLogger.log('Sent new message successfully',
          'FIREBASE_NETWORK_SENT_MESSAGE', '✅');
    } catch (e) {
      AppLogger.logE(
          'Filed to Get messages $e', 'FIREBASE_NETWORK_SENT_MESSAGE', '❌');
    }
  }
}
