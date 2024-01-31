import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/style/app_color.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/form_bloc/bloc/form_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/splash_page/loading_page.dart';
import 'package:flutter_bloc_firebase_2/modules/splash_page/splash_page.dart';

class SubmitForm extends StatelessWidget {
  const SubmitForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return state.isLoading
            ? const LoadingWidget()
            : ElevatedButton(
                onPressed: () {
                  context
                      .read<FormBloc>()
                      .add(const FormSubmitted(value: Status.signUp));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ilacPalette4),
                child: const Text(
                  'Sign Up',
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
