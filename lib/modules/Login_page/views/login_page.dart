import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/constants/app_constants.dart';
import 'package:flutter_bloc_firebase_2/common/style/app_color.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/bloc/login_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/widgets/email_field.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/widgets/login_form.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/widgets/password_field.dart';
import 'package:flutter_bloc_firebase_2/modules/landing_page/views/landing_page.dart';
import 'package:flutter_bloc_firebase_2/modules/splash_page/loading_page.dart';
import 'package:flutter_bloc_firebase_2/modules/splash_page/splash_page.dart';

class LoginPage extends StatefulWidget {
  static const String route = 'login';

  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Size? size;

  @override
  void initState() {
    //TODO: initial anything here
  }

  @override
  Widget build(BuildContext context) {
    size ??= MediaQuery.of(context).size;
    return _builder();
  }

  _builder() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == StateStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LandingPage.route,
            (route) => false,
          );
        } else if (state.status == StateStatus.loading) {
          const LoadingWidget();
        } else if (state.status == StateStatus.failure &&
            (state.email.isNotEmpty && state.password.isNotEmpty)) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Have something wrong"),
          ));
        }
      },
      child: _body(),
    );
  }

  _body() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.ilacPalette4,
      ),
      body: SingleChildScrollView(
        child: Expanded(
            child: Container(
          color: AppColors.ilacPalette4,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 30),
          height: size?.height,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 50,
                  horizontal: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    EmailField(),
                    SizedBox(
                      height: 30,
                    ),
                    PasswordField(),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: LoginForm(),
                    ),
                  ],
                )),
          ),
        )),
      ),
    );
  }
}
