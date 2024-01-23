// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/data/repositories/services/firebase_client.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/bloc/form_bloc/bloc/login_form_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/views/login_page.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/bloc/message_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/repositories/impl/message_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/views/chat_page.dart';
import 'package:flutter_bloc_firebase_2/modules/get_start_page/views/get_start.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/views/home_page.dart';
import 'package:flutter_bloc_firebase_2/modules/landing_page/bloc/landing/bloc/landing_page_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/landing_page/views/landing_page.dart';

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
    DatabaseRepositoryImpl(),
  );

  final LandingPageBloc _landingBloc = LandingPageBloc();

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
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
              BlocProvider.value(
                value: _landingBloc,
              ),
            ],
            child: const GetStart(),
          ),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _loginFormBloc,
              ),
              BlocProvider.value(
                value: _databaseBloc,
              ),
            ],
            child: const LoginPage(),
          ),
        );

      case '/homePage':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _loginFormBloc,
              ),
              BlocProvider.value(
                value: _databaseBloc,
              ),
              BlocProvider.value(
                value: _authenticationBloc,
              ),
              BlocProvider.value(
                value: _formBloc,
              ),
              BlocProvider.value(
                value: _landingBloc,
              ),
            ],
            child: const HomePage(),
          ),
        );
      case '/ladingPage':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _loginFormBloc,
              ),
              BlocProvider.value(
                value: _databaseBloc,
              ),
              BlocProvider.value(
                value: _authenticationBloc,
              ),
              BlocProvider.value(
                value: _formBloc,
              ),
              BlocProvider.value(
                value: _landingBloc,
              ),
              BlocProvider.value(
                value: _messageBloc,
              ),
            ],
            child: LandingPage(),
          ),
        );

      case '/chatPage':
        return MaterialPageRoute(
          builder: (_) => const ChatPage(),
        );

      default:
        return null;
    }
  }

  void dispose() {
    // close bloc.
  }
}
