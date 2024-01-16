import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/models/user.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/authentication_repo.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/database_repo.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormsValidate> {
  final AuthenticationRepository _authenticationRepository;
  final DatabaseRepository _databaseRepository;

  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  bool _isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return true;
  }

  bool _isNameValid(String? displayName) {
    return displayName!.isNotEmpty;
  }

  bool _isAgeValid(int age) {
    return age >= 1 && age <= 120 ? true : false;
  }

  FormBloc(this._authenticationRepository, this._databaseRepository)
      : super(const FormsValidate(
          email: "example@gmail.com",
          age: 0,
          password: '',
          isEmailValid: true,
          isPasswordValid: true,
          isFormValid: false,
          isNameValid: true,
          isAgeValid: true,
          isFormValidateFailed: false,
          isLoading: false,
        )) {
    on<EmailChanged>(onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<NameChanged>(_onNameChanged);
    on<AgeChanged>(_onAgeChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<FormSucceeded>(_onFormSucceeded);
  }
  bool isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<FormsValidate> emit) async {
    UserModel user = UserModel(
      email: state.email,
      password: state.password,
      age: state.age,
      displayName: state.displayName,
    );

    if (event.value == Status.signUp) {
      emit(state.copyWith(
        errorMessage: "",
        isFormValid: _isPasswordValid(state.password) &&
            _isEmailValid(state.email) &&
            _isAgeValid(state.age) &&
            _isNameValid(state.displayName),
        isLoading: true,
      ));
      print("isfromValid${state.isFormValid}");
      if (state.isFormValid) {
        try {
          // Sign up method
          UserCredential? authUser =
              await _authenticationRepository.signUp(user);
          UserModel updatedUser = user.copyWith(
              uid: authUser!.user!.uid,
              isVerified: authUser.user!.emailVerified);
          await _databaseRepository.saveUserData(user);
          if (updatedUser.isVerified!) {
            emit(state.copyWith(
              isLoading: false,
              errorMessage: "",
            ));
          } else {
            emit(state.copyWith(
              isFormValid: false,
              errorMessage: "Please Verify your email",
              isLoading: false,
            ));
          }
        } on FirebaseAuthException catch (e) {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: e.message,
            isFormValid: false,
          ));
        }
      } else {
        emit(state.copyWith(
          isLoading: false,
          isFormValid: false,
          isFormValidateFailed: true,
        ));
      }
    } else if (event.value == Status.signIn) {
      emit(state.copyWith(
        errorMessage: "",
        isFormValid:
            _isPasswordValid(state.password) && _isEmailValid(state.email),
        isLoading: true,
      ));
      if (state.isFormValid) {
        try {
          UserCredential? authUser =
              await _authenticationRepository.signIn(user);
          UserModel updatedUser =
              user.copyWith(isVerified: authUser!.user!.emailVerified);
          if (updatedUser.isVerified!) {
            emit(state.copyWith(isLoading: false, errorMessage: ""));
          } else {
            emit(state.copyWith(
              isFormValid: false,
              errorMessage: "Please Verify your emails",
              isLoading: false,
            ));
          }
        } on FirebaseAuthException catch (e) {
          emit(state.copyWith(
              isLoading: false, errorMessage: e.message, isFormValid: false));
        }
      } else {
        emit(state.copyWith(
            isLoading: false, isFormValid: false, isFormValidateFailed: true));
      }
    }
  }

  _onFormSucceeded(FormSucceeded event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(isFormSuccessful: true));
  }

  _onAgeChanged(AgeChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      age: event.age,
      isAgeValid: _isAgeValid(event.age),
    ));
  }

  Future<void> _onNameChanged(
      NameChanged event, Emitter<FormsValidate> emit) async {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      displayName: event.displayName,
      isNameValid: _isNameValid(event.displayName),
    ));
  }

  Future<void> _onPasswordChanged(
      PasswordChanged event, Emitter<FormsValidate> emit) async {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      isPasswordValid: _isPasswordValid(event.password),
      password: event.password,
    ));
  }

  Future<void> onEmailChanged(
      EmailChanged event, Emitter<FormsValidate> emit) async {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      email: event.email,
      isEmailValid: isEmailValid(event.email),
    ));
  }
}
