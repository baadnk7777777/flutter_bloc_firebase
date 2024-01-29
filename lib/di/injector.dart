import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc_firebase_2/common/core/secure_storage/impl/secure_storage.dart';
import 'package:flutter_bloc_firebase_2/common/core/secure_storage/secure_storage.dart';
import 'package:flutter_bloc_firebase_2/common/core/user_session/impl/user_session.dart';
import 'package:flutter_bloc_firebase_2/common/core/user_session/user_session.dart';
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

  locator.allReady().then((_) {
    AppLogger.log('All Injector is already setup.', 'INJECTOR', '💉');
  });
}

// class Injector {
//   late UserSession _userSession;
//   late SecureStorage _secureStorage;
//   late FirebaseNetwork _firebaseNetwork;

//   static final Injector _singleton = Injector._singleton;
//   static Injector get instance => _singleton;

//   Injector._internal();

//   // void setup({
//   //   required FirebaseNetwork firebaseClient,
//   //   required UserSession userSession,
//   //   required SecureStorage secureStorage,
//   // }) {
//   //   _firebaseNetwork = firebaseClient;
//   //   _userSession = userSession;
//   //   _secureStorage = secureStorage;
//   // }

//   void setup() {}

//   UserSession get userSession => _userSession;
//   SecureStorage get secureStorage => _secureStorage;
//   FirebaseNetwork get firebaseNetwork => _firebaseNetwork;
// }
