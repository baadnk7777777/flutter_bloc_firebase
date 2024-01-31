import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_firebase_2/common/constants/app_constants.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/models/room.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/repositories/impl/chat_member_repo_impl.dart';

part 'chat_member_event.dart';
part 'chat_member_state.dart';

class ChatMemberBloc extends Bloc<ChatMemberEvent, ChatMemberState> {
  final ChatMemberRepositoryRepositoyImpl chatMemberRepositoryRepositoyImpl;
  ChatMemberBloc({required this.chatMemberRepositoryRepositoyImpl})
      : super(ChatMemberInitial()) {
    on<FetchChatRoomsbyId>(_onFetchChatRoomsbyId);
  }

  Future<void> _onFetchChatRoomsbyId(
      FetchChatRoomsbyId event, Emitter<ChatMemberState> emit) async {
    emit(state.copyWith(
      status: StateStatus.loading,
    ));
    final Either<String, List<Room>> result =
        await chatMemberRepositoryRepositoyImpl.getChatRoomById(event.uId);

    result.fold(
        (left) => emit(state.copyWith(
              status: StateStatus.failure,
              rooms: <Room>[],
            )), (List<Room> right) {
      List<Room> newRoom = right
          .where((newRoom) => !state.rooms.any(
                (existingRoom) => newRoom.chatId == existingRoom.chatId,
              ))
          .toList();

      emit(state.copyWith(
        status: StateStatus.success,
        rooms: List.from(state.rooms)..addAll(newRoom),
      ));
    });
  }
}
