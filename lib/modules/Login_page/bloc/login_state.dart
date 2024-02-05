part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    // UserModel? userModel,
    this.email = '',
    this.password = '',
    this.status = StateStatus.initial,
    this.isFormValid = false,
    this.isLoginVerified = false,
    this.uid = '',
  });
  final StateStatus status;
  // final UserModel user;
  final bool isFormValid;
  final String email;
  final String password;
  final bool isLoginVerified;
  final String uid;

  LoginState copyWith({
    // UserModel? userModel,
    String? email,
    String? password,
    StateStatus? status,
    bool? isFormValid,
    bool? isLoginVerified,
    String? uid,
  }) =>
      LoginState(
        // userModel: userModel ?? user,
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        isFormValid: isFormValid ?? this.isFormValid,
        isLoginVerified: isFormValid ?? this.isLoginVerified,
        uid: uid ?? this.uid,
      );

  @override
  List<Object?> get props =>
      [status, isFormValid, email, password, isLoginVerified, uid];
}
