part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventEmailChanged extends LoginEvent {
  final String email;
  const LoginEventEmailChanged({required this.email});
  @override
  List<Object> get props => [email];
}

class LoginEventPasswordChanged extends LoginEvent {
  final String password;
  const LoginEventPasswordChanged({required this.password});
  @override
  List<Object> get props => [password];
}

class LoginEventFormSubmitted extends LoginEvent {
  const LoginEventFormSubmitted();
  @override
  List<Object> get props => [];
}

class LoginEventLogout extends LoginEvent {
  const LoginEventLogout();
  @override
  List<Object> get props => [];
}

class LoginEventGetData extends LoginEvent {
  const LoginEventGetData();
  @override
  List<Object> get props => [];
}
