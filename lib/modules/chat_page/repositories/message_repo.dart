import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/models/message.dart';

abstract class MessageRepository {
  Future<Either<String, List<Message>>> getAllMessages();

  Future<void> sendMessage(String message, String uId, int chatId);
}
