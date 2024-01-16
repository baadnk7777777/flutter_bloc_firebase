part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final String? displayName;
  const AuthenticationSuccess({this.displayName});

  @override
  List<Object?> get props => [displayName];
}

class AuthenticationFailure extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

// abstract class AuthenticationState extends Equatable {
//   const AuthenticationState();

//   @override
//   List<Object> get props => [];
// }

// final class AuthenticationInitial extends AuthenticationState {}

// class AuthenticationLoading extends AuthenticationState {}

// class AuthenticationLogout extends AuthenticationState {
//   final bool isLogout;

//   const AuthenticationLogout({required this.isLogout});

//   @override
//   List<Object> get props => [isLogout];
// }

// class AuthenticationSuccess extends AuthenticationState {
//   final UserModel user;
//   const AuthenticationSuccess({required this.user});
//   @override
//   List<Object> get props => [user];
// }

// class AuthenticationFailure extends AuthenticationState {
//   final String errorMessage;
//   const AuthenticationFailure(this.errorMessage);
//   @override
//   List<Object> get props => [errorMessage];
// }
