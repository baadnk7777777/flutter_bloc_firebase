import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc_firebase_2/data/repositories/services/firebase_client.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/models/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseClient authService = FirebaseClient();
  AuthenticationBloc() : super(AuthenticationInitial()) {
    // on<AuthenticationEvent>((event, emit) {});

    // on<AuthenticationEvent>(_onSignUpUser);
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

  // Future<void> _onSignUpUser(
  //   AuthenticationEvent event,
  //   Emitter<AuthenticationState> emit,
  // ) async {
  //   if(event is AuthenticationStarted) {
  //     UserModel user = await // repo
  //     if(user.uid != "uid") {
  //       String? displayName = emit(const AuthenticationSuccess())
  //     }else {
  //       emit(AuthenticationFailure());
  //     }
  //   } else if(event is AuthenticationSignedOut) {
  //     await // firebaseRepo
  //   }
  // emit(AuthenticationLoading());
  // try {
  //   final UserModel? user =
  //       await authService.signUpUser(event.email, event.password);
  //   if (user != null) {
  //     emit(AuthenticationSuccess(user: user));
  //   } else {
  //     emit(const AuthenticationFailure('Create user Failed'));
  //   }
  // } catch (e) {
  //   print(e);
  // }
  // }
}
