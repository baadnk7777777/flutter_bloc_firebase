part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignUpUser extends AuthenticationEvent {
  final String email;
  final String password;

  const SignUpUser({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthenticationEvent {}
