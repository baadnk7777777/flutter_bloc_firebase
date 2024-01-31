import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc_firebase_2/common/core/secure_storage/impl/secure_storage.dart';
import 'package:flutter_bloc_firebase_2/common/core/secure_storage/secure_storage.dart';
import 'package:flutter_bloc_firebase_2/common/core/user_session/impl/user_session.dart';
import 'package:flutter_bloc_firebase_2/common/core/user_session/user_session.dart';
import 'package:flutter_bloc_firebase_2/modules/add_request_page/repositories/add_request_repo.dart';
import 'package:flutter_bloc_firebase_2/modules/add_request_page/repositories/impl/add_request_repo_impl/add_request_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/repositories/chat_member_repo.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/repositories/impl/chat_member_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/repositories/impl/message_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/repositories/message_repo.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/repositories/impl/services_request_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/my_request_page/repositories/services_request_repo.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/authentication_repo.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/database_repo.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/impl/authentication_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/impl/database_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/network/firebase_network.dart';
import 'package:flutter_bloc_firebase_2/network/impl/firebase_network_impl.dart';
import 'package:flutter_bloc_firebase_2/utils/custom_logger.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<FirebaseNetwork>(FirebaseNetworkImpl());
  locator
      .registerSingleton<SecureStorage>(SecureStorageImpl('internshipsolar'));
  SecureStorage secureStorage = locator<SecureStorage>();
  locator.registerSingleton<UserSession>(UserSessionImpl(secureStorage));
  // Repository.
  locator.registerSingleton<DatabaseRepository>(DatabaseRepositoryImpl());
  locator.registerSingleton<MessageRepository>(
      MessageRepositoyImpl(firebaseNetwork: locator<FirebaseNetwork>()));
  locator.registerSingleton<AuthenticationRepository>(
      AuthenticationRepositoryImpl());
  locator.registerSingleton<AddRequestRepository>(
      AddRequestRepositoyImpl(firebaseClient: locator<FirebaseNetwork>()));
  locator.registerSingleton<ServicesRequestRepository>(
      ServicesRequestRepositoryImpl(
          firebaseClient: locator<FirebaseNetwork>()));
  locator.registerSingleton<ChatMemberRepository>(
      ChatMemberRepositoryRepositoyImpl(
          firebaseNetwork: locator<FirebaseNetwork>()));
  locator.allReady().then((_) {
    AppLogger.log('All Injector is already setup.', 'INJECTOR', '💉');
  });
}
