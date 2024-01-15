part of 'message_bloc.dart';

class MessageState extends Equatable {
  const MessageState({
    this.messagesList = const <Message>[],
    this.status = StateStatus.initial,
  });

  MessageState copyWith({
    List<Message>? messagesList,
    StateStatus? status,
  }) =>
      MessageState(
        messagesList: messagesList ?? this.messagesList,
        status: status ?? this.status,
      );

  final List<Message> messagesList;
  final StateStatus status;

  @override
  List<Object?> get props => [messagesList, status];
}

final class MessageInitial extends MessageState {}
