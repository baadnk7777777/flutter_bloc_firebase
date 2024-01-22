import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/common/constants/app_constants.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/models/user.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/authentication_repo.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/database_repo.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final AuthenticationRepository _authenticationRepository;
  final DatabaseRepository _databaseRepository;

  LoginFormBloc(this._authenticationRepository, this._databaseRepository)
      : super(const LoginFormState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  Future<void> _onEmailChanged(
      EmailChanged event, Emitter<LoginFormState> emit) async {
    emit(state.copyWith(
      email: event.email,
    ));
  }

  Future<void> _onPasswordChanged(
      PasswordChanged event, Emitter<LoginFormState> emit) async {
    emit(state.copyWith(
      password: event.password,
    ));
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<LoginFormState> emit) async {
    UserModel user = UserModel(
      email: state.email,
      password: state.password,
    );
    emit(
      state.copyWith(
        email: state.email,
        password: state.password,
        status: StateStatus.loading,
        isFormValid:
            _isEmailValid(state.email) && _isPasswordValid(state.password),
      ),
    );
    if (state.isFormValid) {
      UserCredential? authUser = await _authenticationRepository.signIn(user);

      UserModel updateUser =
          user.copyWith(isVerified: authUser != null ? true : false);
      await _databaseRepository.saveUserData(updateUser);
      if (updateUser.isVerified!) {
        emit(state.copyWith(
          uid: authUser!.user!.uid,
          status: StateStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: StateStatus.failure,
        ));
      }
    } else {
      emit(state.copyWith(
        status: StateStatus.failure,
        isFormValid: false,
        isLoginVerified: false,
      ));
    }
  }
}
