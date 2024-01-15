import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_firebase_2/data/repositories/services/firebase_client.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/models/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseClient authService = FirebaseClient();
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});

    on<SignUpUser>(_onSignUpUser);
    on<SignOut>(_onSignOut);
  }

  Future<void> _onSignOut(
    SignOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading(isLoading: true));

    try {
      await authService
          .signOutUser(); // Make sure to await the sign-out operation
    } catch (e) {
      print('Error during sign-out: $e');
      // Handle the error appropriately, you might want to emit an error state
      emit(AuthenticationFailure('Error during sign-out: $e'));
    } finally {
      emit(AuthenticationLoading(isLoading: false));
    }
  }

  Future<void> _onSignUpUser(
    SignUpUser event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationLoading(isLoading: true));
    try {
      final UserModel? user =
          await authService.signUpUser(event.email, event.password);
      if (user != null) {
        emit(AuthenticationSuccess(user: user));
      } else {
        emit(const AuthenticationFailure('Create user Failed'));
      }
    } catch (e) {
      print(e);
    }
    emit(const AuthenticationLoading(isLoading: false));
  }
}
