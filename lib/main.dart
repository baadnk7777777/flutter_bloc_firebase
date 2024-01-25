import 'dart:async';
import 'dart:isolate';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/app.dart';
import 'package:flutter_bloc_firebase_2/common/config/app_configs.dart';
import 'package:flutter_bloc_firebase_2/common/core/secure_storage/impl/secure_storage.dart';
import 'package:flutter_bloc_firebase_2/common/core/user_session/impl/user_session.dart';
import 'package:flutter_bloc_firebase_2/firebase_options.dart';
import 'package:flutter_bloc_firebase_2/modules/welcome_page/views/welcome_page.dart';
import 'package:flutter_bloc_firebase_2/router/app_route.dart';
import 'package:flutter_bloc_firebase_2/utils/app_bloc_observer.dart';

void main() {}

Future<void> handleError(Object error, StackTrace? stackTrace) async {
  await FirebaseCrashlytics.instance
      .recordError(error, stackTrace, fatal: true);
}

void run(Config config) async {
  // Use runZonedGuarded for error handling
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    // Use it in Injector for use any where you want.
    final secureStorage = SecureStorageImpl('internshipsolar');
    final userSession = UserSessionImpl(secureStorage);

    //ดังนั้น, โค้ดนี้ถูกใช้เพื่อลงทะเบียน listener
    //ที่จะทำงานเมื่อมีข้อผิดพลาดเกิดขึ้นใน Isolate
    //และจะนำข้อมูลข้อผิดพลาดนั้นไปให้ฟังก์ชัน handleError \
    //ทำการจัดการ.

    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await handleError(errorAndStacktrace.first, errorAndStacktrace.last);
    }).sendPort);
    runApp(
      EasyLocalization(
        path: config.localizationPath,
        supportedLocales: config.supportedLocales,
        fallbackLocale: config.fallbackLocale,
        child: const App(),
      ),
    );
  }, (Object error, StackTrace stack) async {
    await handleError(error, stack);
  });
}

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   BlocOverrides.runZoned(
//     () => runApp(const MyApp()),
//     blocObserver: AppBlocObserver(),
//   );
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final AppRouter _appRouter = AppRouter();
//   @override
//   void dispose() {
//     _appRouter.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // showPerformanceOverlay: true,
//       theme: ThemeData(
//         primaryColor: Colors.transparent,
//         scaffoldBackgroundColor: Colors.transparent,
//       ),
//       debugShowCheckedModeBanner: false,
//       title: 'InternShip App Chat',
//       onGenerateRoute: _appRouter.onGenerateRoute,
//     );
//   }
// }
