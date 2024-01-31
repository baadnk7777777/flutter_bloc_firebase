part of 'chat_member_bloc.dart';

class ChatMemberState extends Equatable {
  final List<Room> rooms;
  final StateStatus status;
  const ChatMemberState({
    this.rooms = const <Room>[],
    this.status = StateStatus.initial,
  });

  ChatMemberState copyWith({
    List<Room>? rooms,
    StateStatus? status,
  }) =>
      ChatMemberState(
        rooms: rooms ?? this.rooms,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [rooms, status];
}

final class ChatMemberInitial extends ChatMemberState {}
