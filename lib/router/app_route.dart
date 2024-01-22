// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/data/repositories/services/firebase_client.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/bloc/form_bloc/bloc/login_form_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/views/login_page.dart';
import 'package:flutter_bloc_firebase_2/modules/authentication_page/views/authentication_page.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/views/chat_page.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/bloc/message_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/repositories/impl/message_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/views/home_page.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/auth_bloc/bloc/authentication_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/database_bloc/bloc/database_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/form_bloc/bloc/form_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/impl/authentication_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/impl/database_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/welcome_page/views/welcome_page.dart';

class AppRouter {
  final MessageBloc _messageBloc = MessageBloc(
      messageRepositoyImpl: MessageRepositoyImpl(
    firebaseClient: FirebaseClient(),
  ));

  final AuthenticationBloc _authenticationBloc = AuthenticationBloc(
    AuthenticationRepositoryImpl(),
  );
  final DatabaseBloc _databaseBloc = DatabaseBloc(DatabaseRepositoryImpl());
  final FormBloc _formBloc = FormBloc(
    AuthenticationRepositoryImpl(),
    DatabaseRepositoryImpl(),
  );

  final LoginFormBloc _loginFormBloc = LoginFormBloc(
    AuthenticationRepositoryImpl(),
  );

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const WelcomePage(),
        );

      // case '/chatPage':
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider.value(
      //       value: _messageBloc,
      //       child: const ChatPage(),
      //     ),
      //   );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _loginFormBloc,
              ),
            ],
            child: const LoginPage(),
          ),
        );

      case '/auth':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _authenticationBloc,
              ),
              BlocProvider.value(
                value: _formBloc,
              ),
              BlocProvider.value(
                value: _loginFormBloc,
              ),
              BlocProvider.value(
                value: _messageBloc,
              ),
            ],
            child: const AuthenticationPage(),
          ),
        );

      case '/homePage':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _messageBloc,
              ),
              BlocProvider.value(
                value: _authenticationBloc,
              ),
              BlocProvider.value(
                value: _loginFormBloc,
              ),
            ],
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
