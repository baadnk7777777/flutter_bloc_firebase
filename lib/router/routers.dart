import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/core/user_session/user_session.dart';
import 'package:flutter_bloc_firebase_2/di/injector.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/bloc/form_bloc/bloc/login_form_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/views/login_page.dart';
import 'package:flutter_bloc_firebase_2/modules/add_request_page/bloc/add_request/bloc/add_request_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/add_request_page/repositories/impl/add_request_repo_impl/add_request_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/add_request_page/views/add_request_page.dart';
import 'package:flutter_bloc_firebase_2/modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/bloc/message_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/repositories/impl/message_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/get_start_page/views/get_start.dart';
import 'package:flutter_bloc_firebase_2/modules/landing_page/bloc/landing/bloc/landing_page_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/landing_page/views/landing_page.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/database_bloc/bloc/database_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/form_bloc/bloc/form_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/impl/authentication_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/repository/impl/database_repo_impl.dart';
import 'package:flutter_bloc_firebase_2/modules/splash_page/splash_page.dart';
import 'package:flutter_bloc_firebase_2/network/firebase_network.dart';
import 'package:flutter_bloc_firebase_2/utils/custom_logger.dart';

class YPRouter {
  static T _args<T>(BuildContext context) {
    return ModalRoute.of(context)?.settings.arguments as T;
  }

  static Map<String, WidgetBuilder> routes = {
    AddRequestPage.route: (context) => BlocProvider(
          create: (context) {
            AppLogger.log('AddRequestBloc created', 'BLOC_PROVIDER', '📦');
            return AddRequestBloc(
                addRequestRepositoyImpl: AddRequestRepositoyImpl(
              firebaseClient: locator<FirebaseNetwork>(),
            ));
          },
          child: const AddRequestPage(),
        ),
    LoadingPage.route: (context) => const LoadingPage(),
    GetStart.route: (context) {
      AppLogger.log('GetStart Bloc created', 'BLOC_PROVIDER', '📦');
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginFormBloc(
              userSession: locator<UserSession>(),
              authenticationRepository: AuthenticationRepositoryImpl(),
              databaseRepository: DatabaseRepositoryImpl(),
            ),
          ),
          BlocProvider(
            create: (context) => LandingPageBloc(),
          ),
        ],
        child: const GetStart(),
      );
    },
    LandingPage.route: (context) {
      AppLogger.log('LandingPage Bloc created', 'BLOC_PROVIDER', '📦');

      return MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => LoginFormBloc(
            userSession: locator<UserSession>(),
            authenticationRepository: AuthenticationRepositoryImpl(),
            databaseRepository: DatabaseRepositoryImpl(),
          ),
        ),
        BlocProvider(
          create: (context) => LandingPageBloc(),
        ),
        BlocProvider(
          create: (context) => DatabaseBloc(
            DatabaseRepositoryImpl(),
          ),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => FormBloc(
            AuthenticationRepositoryImpl(),
            DatabaseRepositoryImpl(),
          ),
        ),
        BlocProvider(
            create: (context) => MessageBloc(
                  messageRepositoyImpl: MessageRepositoyImpl(
                    firebaseNetwork: locator<FirebaseNetwork>(),
                  ),
                )),
      ], child: LandingPage());
    },
    LoginPage.route: (context) {
      AppLogger.log('LoginPage Bloc created', 'BLOC_PROVIDER', '📦');

      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginFormBloc(
              userSession: locator<UserSession>(),
              authenticationRepository: AuthenticationRepositoryImpl(),
              databaseRepository: DatabaseRepositoryImpl(),
            ),
          ),
        ],
        child: const LoginPage(),
      );
    }
  };
}
