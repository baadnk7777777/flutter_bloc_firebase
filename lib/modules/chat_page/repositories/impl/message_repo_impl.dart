import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_firebase_2/data/repositories/services/firebase_client.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/models/message.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/repositories/message_repo.dart';
import 'package:flutter_bloc_firebase_2/network/firebase_network.dart';

class MessageRepositoyImpl implements MessageRepository {
  final FirebaseNetwork _firebaseClient;

  MessageRepositoyImpl({required FirebaseNetwork firebaseNetwork})
      : _firebaseClient = firebaseNetwork;

  @override
  Future<Either<String, List<Message>>> getAllMessages() async {
    try {
      final List<Message> messages = await _firebaseClient.getAllMessages();
      return Right(messages);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> sendMessage(String message, String uId, int chatId) async {
    try {
      await _firebaseClient.sentMessage(message, uId, chatId);
    } catch (e) {
      print(e);
    }
  }
}
