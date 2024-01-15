part of 'message_bloc.dart';

@immutable
abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class FetchMesageEvent extends MessageEvent {}

class SendMessageEvent extends MessageEvent {
  final String message;
  final int uerId;
  const SendMessageEvent(this.uerId, {required this.message});
}
