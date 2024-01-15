// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/data/repositories/services/firebase_client.dart';
import 'package:flutter_bloc_firebase_2/modules/authentication_page/views/authentication_page.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/bloc/message_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/repositories/impl/message_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/views/home_page.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/authentication_bloc.dart';

class AppRouter {
  final MessageBloc _messageBloc = MessageBloc(
      messageRepositoyImpl: MessageRepositoyImpl(
    firebaseClient: FirebaseClient(),
  ));

  final AuthenticationBloc _authenticationBloc = AuthenticationBloc();

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _authenticationBloc,
            child: const AuthenticationPage(),
          ),
        );

      case '/homePage':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _messageBloc,
            child: const HomePage(),
          ),
        );

      default:
        return null;
    }
  }

  void dispose() {
    // close bloc.
  }
}
