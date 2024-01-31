part of 'message_bloc.dart';

class MessageState extends Equatable {
  const MessageState({
    this.messagesList = const <Message>[],
    this.status = StateStatus.initial,
    this.chatId = 0,
  });

  MessageState copyWith({
    List<Message>? messagesList,
    StateStatus? status,
    int? chatId,
  }) =>
      MessageState(
        messagesList: messagesList ?? this.messagesList,
        status: status ?? this.status,
        chatId: chatId ?? this.chatId,
      );

  final List<Message> messagesList;
  final StateStatus status;
  final int chatId;

  @override
  List<Object?> get props => [messagesList, status, chatId];
}

final class MessageInitial extends MessageState {}
