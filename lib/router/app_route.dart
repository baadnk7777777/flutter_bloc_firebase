// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/data/repositories/services/firebase_client.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/bloc/message_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/repositories/impl/message_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/views/home_page.dart';

class AppRouter {
  final MessageBloc _messageBloc = MessageBloc(
      messageRepositoyImpl: MessageRepositoyImpl(
    firebaseClient: FirebaseClient(),
  ));

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
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
