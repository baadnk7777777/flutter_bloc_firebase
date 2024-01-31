import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_member_event.dart';
part 'chat_member_state.dart';

class ChatMemberBloc extends Bloc<ChatMemberEvent, ChatMemberState> {
  ChatMemberBloc() : super(ChatMemberInitial()) {
    on<ChatMemberEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
