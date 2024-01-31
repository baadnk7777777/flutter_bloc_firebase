import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/models/room.dart';

abstract class ChatMemberRepository {
  Future<Either<String, List<Room>>> getChatRoomById(String uId);
}
