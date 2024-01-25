import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/config/app_configs.dart';
import 'package:flutter_bloc_firebase_2/firebase_options.dart';
import 'package:flutter_bloc_firebase_2/modules/welcome_page/views/welcome_page.dart';
import 'package:flutter_bloc_firebase_2/router/app_route.dart';
import 'package:flutter_bloc_firebase_2/utils/app_bloc_observer.dart';

void main() {}

void run(Config config) async {}

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
