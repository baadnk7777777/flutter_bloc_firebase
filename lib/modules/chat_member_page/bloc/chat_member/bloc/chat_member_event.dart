part of 'chat_member_bloc.dart';

@immutable
abstract class ChatMemberEvent extends Equatable {
  const ChatMemberEvent();

  @override
  List<Object> get props => [];
}

class FetchChatRoomsbyId extends ChatMemberEvent {
  final String uId;
  const FetchChatRoomsbyId(this.uId);
}
