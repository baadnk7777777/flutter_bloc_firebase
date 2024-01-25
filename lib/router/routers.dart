import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/modules/splash_page/splash_page.dart';

class YPRouter {
  static T _args<T>(BuildContext context) {
    return ModalRoute.of(context)?.settings.arguments as T;
  }

  static Map<String, WidgetBuilder> routes = {
    LoadingPage.route: (context) => const LoadingPage(),
  };
}
