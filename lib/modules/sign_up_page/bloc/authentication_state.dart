part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {
  final bool isLoading;
  const AuthenticationLoading({required this.isLoading});
  @override
  List<Object> get props => [isLoading];
}

class AuthenticationSuccess extends AuthenticationState {
  final UserModel user;
  const AuthenticationSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationFailure extends AuthenticationState {
  final String errorMessage;
  const AuthenticationFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
