import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/splash_page/splash_page.dart';
import 'package:flutter_bloc_firebase_2/router/routers.dart';
import 'package:flutter_bloc_firebase_2/utils/navigator_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class App extends StatelessWidget {
  const App({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => AuthenticationBloc(),
          ),
          // BlocProvider(create:(ctx) => );
        ],
        child: MaterialApp(
          builder: EasyLoading.init(),
          initialRoute: LoadingPage.route,
          routes: YPRouter.routes,
          title: 'Solar Internship',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          navigatorObservers: [observer],
          // Can navigate to any way you want Widet, Services, Class.
          navigatorKey: NavigationService.navigatorKey,
        ));
  }
}
