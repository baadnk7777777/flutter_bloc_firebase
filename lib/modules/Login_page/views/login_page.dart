import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/constants/app_constants.dart';
import 'package:flutter_bloc_firebase_2/common/style/app_color.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/bloc/form_bloc/bloc/login_form_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/widgets/email_field.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/widgets/login_form.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/widgets/password_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginFormBloc, LoginFormState>(
      listener: (context, state) {
        if (state.status == StateStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/homePage', (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.ilacPalette4,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: AppColors.ilacPalette4,
            padding: const EdgeInsets.only(top: 30),
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
                      Center(child: LoginForm()),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
