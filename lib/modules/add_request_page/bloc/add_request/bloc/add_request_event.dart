part of 'add_request_bloc.dart';

@immutable
abstract class AddRequestEvent extends Equatable {
  const AddRequestEvent();
}

class AddRequest extends AddRequestEvent {
  @override
  List<Object> get props => [];
}

class RequestTypeChanged extends AddRequestEvent {
  final String type;
  const RequestTypeChanged(this.type);
  @override
  List<Object> get props => [type];
}

class RequestIssuesChanged extends AddRequestEvent {
  final String issues;
  const RequestIssuesChanged(this.issues);
  @override
  List<Object> get props => [issues];
}

class RequestSubmitted extends AddRequestEvent {
  final String uId;
  const RequestSubmitted(this.uId);
  @override
  List<Object> get props => [uId];
}
