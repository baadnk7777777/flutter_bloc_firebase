import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_firebase_2/data/repositories/services/firebase_client.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/models/message.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/repositories/message_repo.dart';

class MessageRepositoyImpl implements MessageRepository {
  final FirebaseClient _firebaseClient;

  MessageRepositoyImpl({required FirebaseClient firebaseClient})
      : _firebaseClient = firebaseClient;

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
