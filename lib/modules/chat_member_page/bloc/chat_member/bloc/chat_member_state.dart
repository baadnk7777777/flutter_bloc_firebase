part of 'chat_member_bloc.dart';

sealed class ChatMemberState extends Equatable {
  const ChatMemberState();
  
  @override
  List<Object> get props => [];
}

final class ChatMemberInitial extends ChatMemberState {}
