import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc_firebase_2/data/repositories/services/firebase_client.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/models/user.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/authentication_repo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  final FirebaseClient authService = FirebaseClient();
  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationInitial()) {
    // on<AuthenticationEvent>((event, emit) {});

    on<AuthenticationEvent>(_onSignUpUser);
    // on<SignOut>(_onSignOut);
  }

  // Future<void> _onSignOut(
  //   SignOut event,
  //   Emitter<AuthenticationState> emit,
  // ) async {
  //   emit(AuthenticationLoading());

  //   try {
  //     print("Hello");
  //     authService.signOutUser(); // Make sure to await the sign-out operation
  //     print(FirebaseAuth.instance.authStateChanges());
  //   } catch (e) {
  //     print('Error during sign-out: $e');
  //     // Handle the error appropriately, you might want to emit an error state
  //     emit(AuthenticationFailure('Error during sign-out: $e'));
  //   }
  // }

  Future<void> _onSignUpUser(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (event is AuthenticationStarted) {
      UserModel user = await _authenticationRepository.getCurrentUser().first;
      print(user);
      if (user.uid != "uid") {
        String? displayName =
            await _authenticationRepository.retrieveUserName(user);
        emit(AuthenticationSuccess(displayName: displayName));
      } else {
        emit(AuthenticationFailure());
      }
    } else if (event is AuthenticationSignedOut) {
      await _authenticationRepository.signOut();
      emit(AuthenticationFailure());
    }
  }
}
