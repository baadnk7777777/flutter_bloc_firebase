import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/models/room.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/repositories/chat_member_repo.dart';
import 'package:flutter_bloc_firebase_2/modules/splash_page/splash_page_import.dart';

class ChatMemberRepositoryRepositoyImpl implements ChatMemberRepository {
  final FirebaseNetwork _firebaseNetwork;

  ChatMemberRepositoryRepositoyImpl({required FirebaseNetwork firebaseNetwork})
      : _firebaseNetwork = firebaseNetwork;

  @override
  Future<Either<String, List<Room>>> getChatRoomById(String uId) async {
    try {
      final List<Room> rooms = await _firebaseNetwork.getRoomsById(uId);
      return Right(rooms);
    } catch (e, stackTrace) {
      AppLogger.logE('$e', 'getChatRoomById', '$stackTrace');
      return Left(e.toString());
    }
  }
}
