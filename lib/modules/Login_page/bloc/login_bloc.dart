import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/common/constants/app_constants.dart';
import 'package:flutter_bloc_firebase_2/common/core/user_session/user_session.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/models/user.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/authentication_repo.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/database_repo.dart';
import 'package:flutter_bloc_firebase_2/utils/custom_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;
  final DatabaseRepository _databaseRepository;
  final UserSession _userSession;

  LoginBloc({
    required UserSession userSession,
    required AuthenticationRepository authenticationRepository,
    required DatabaseRepository databaseRepository,
  })  : _authenticationRepository = authenticationRepository,
        _databaseRepository = databaseRepository,
        _userSession = userSession,
        super(const LoginState()) {
    on<LoginEventEmailChanged>(_onEmailChanged);
    on<LoginEventPasswordChanged>(_onPasswordChanged);
    on<LoginEventFormSubmitted>(_onFormSubmitted);
    on<LoginEventLogout>(_onLogout);
    on<LoginEventGetData>(_onGetData);
  }

  Future<void> _onLogout(
      LoginEventLogout event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      status: StateStatus.loading,
    ));
    await _authenticationRepository.signOut();
    _deleteData();
    emit(state.copyWith(
      status: StateStatus.failure,
      isFormValid: false,
      isLoginVerified: false,
    ));
  }

  Future<void> _deleteData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('uId');
    prefs.remove('email');
  }

  Future<void> _onGetData(
      LoginEventGetData event, Emitter<LoginState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    emit(state.copyWith(
      status: StateStatus.loading,
    ));

    final String uId = prefs.getString('uId') ?? 'Unknown';
    final String displayName = prefs.getString('displayName') ?? 'Unknown';

    emit(state.copyWith(
      status: StateStatus.success,
      isFormValid: true,
      isLoginVerified: true,
      uid: uId,
      email: displayName,
    ));
  }

  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  Future<void> _onEmailChanged(
      LoginEventEmailChanged event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      status: StateStatus.initial,
      email: event.email,
    ));
  }

  Future<void> _onPasswordChanged(
      LoginEventPasswordChanged event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      status: StateStatus.initial,
      password: event.password,
    ));
  }

  _saveToken(String accessToken, String refreshToken, String displayName,
      String email, String uid) async {
    await _userSession.saveSession(
        accessToken, refreshToken, displayName, email, uid);
  }

  Future<void> _onFormSubmitted(
      LoginEventFormSubmitted event, Emitter<LoginState> emit) async {
    if (_isEmailValid(state.email)) {
      //TODO: emit some validation message here
      return;
    }
    if (_isEmailValid(state.email)) {
      //TODO: emit some validation message here
      return;
    }

    //TODO: create new model call "LoginForm" instead of using UserModel
    UserModel form = UserModel(
      email: state.email,
      password: state.password,
    );
    try {

      UserCredential? userCred = await _authenticationRepository.signIn(form);
      String? token = await _authenticationRepository.retrieveUserToken();
      List<UserModel> users = await _databaseRepository.retrieveUserData();
      UserModel? myUser =
          users.firstWhere((u) => u.email == userCred?.user?.email);
      if (myUser != null && token != null && userCred != null) {
        _saveToken(
          token,
          token,
          myUser?.displayName ?? "",
          myUser?.email ?? "",
          myUser?.uid ?? "",
        );

        emit(state.copyWith(
          uid: myUser?.uid,
          email: myUser?.email,
          status: StateStatus.success,
        ));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('uId', myUser.uid ?? "");
        prefs.setString('email', myUser.email ?? "");
      }
    } catch (e, stacktrace) {
      //TODO: find a way to return server's message error or network error
      debugPrintStack(stackTrace: stacktrace);
      emit(state.copyWith(
        status: StateStatus.failure,
        isFormValid: false,
        isLoginVerified: false,
      ));
    }
  }
}
