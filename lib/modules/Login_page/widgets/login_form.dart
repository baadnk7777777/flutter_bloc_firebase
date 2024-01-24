import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/constants/app_constants.dart';
import 'package:flutter_bloc_firebase_2/common/style/app_color.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/bloc/form_bloc/bloc/login_form_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/splash_page/splash_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return state.status == StateStatus.loading
            ? const LoadingPage()
            : ElevatedButton(
                onPressed: () {
                  context.read<LoginFormBloc>().add(const FormSubmitted());
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ilacPalette4),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'poppins',
                    fontSize: 20,
                  ),
                ),
              );
      },
    );
  }
}
