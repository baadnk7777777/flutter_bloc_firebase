import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/models/message.dart';
import 'package:flutter_bloc_firebase_2/network/firebase_network.dart';
import 'package:flutter_bloc_firebase_2/network/impl/firebase_network_error.dart';
import 'package:uuid/uuid.dart';

class FirebaseNetworkImpl implements FirebaseNetwork {
  final CollectionReference _messageCollection =
      FirebaseFirestore.instance.collection('messages');
  final Uuid uuid = const Uuid();

  @override
  Future<List<Message>> getAllMessages() async {
    try {
      print("HIII");
      QuerySnapshot querySnapshot = await _messageCollection.get();
      List<Message> messages = querySnapshot.docs
          .map((e) => Message.fromDocumentSnapshot(e))
          .toList();
      print(messages);
      return messages;
    } catch (e) {
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
  // TODO: implement firebaseFirestore
  FirebaseFirestore get firebaseFirestore => throw UnimplementedError();
}
