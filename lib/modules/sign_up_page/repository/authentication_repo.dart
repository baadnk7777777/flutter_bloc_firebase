import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/models/user.dart';

abstract class AuthenticationRepository {
  Stream<UserModel> getCurrentUser();
  Future<UserCredential?> signUp(UserModel user);
  Future<UserCredential?> signIn(UserModel user);
  Future<void> signOut();
  Future<String?> retrieveUserName(UserModel user);
  Future<String?> retrieveUserToken();
}
