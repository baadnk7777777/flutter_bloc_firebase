import 'package:flutter_bloc_firebase_2/modules/sign_up_page/models/user.dart';

abstract class DatabaseRepository {
  Future<void> saveUserData(UserModel user);
  Future<List<UserModel>> retrieveUserData();
}
