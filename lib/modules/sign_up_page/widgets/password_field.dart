import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/style/app_color.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/form_bloc/bloc/form_bloc.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          // รู้ขนาดที่แน่นอน ควรใช้ Sizebox
          width: size.width * 0.8,
          child: TextField(
            onChanged: (value) {
              context.read<FormBloc>().add(PasswordChanged(password: value));
            },
            obscureText: true,
            style: const TextStyle(
              color: Colors.black54,
              fontFamily: "poppins",
              fontSize: 18,
            ),
            decoration: InputDecoration(
                prefixIcon: const Icon(CupertinoIcons.lock_fill),
                suffixIcon: const Icon(CupertinoIcons.eye_slash_fill),
                labelText: 'Password',
                helperText: 'Password must be at least 8 characters',
                helperMaxLines: 2,
                errorText: !state.isPasswordValid
                    ? 'Password must be at least 8 characters'
                    : null,
                errorMaxLines: 2,
                hintText: 'Password',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 10.0,
                ),
                filled: true,
                fillColor: AppColors.ilacPalette3,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                )),
          ),
        );
      },
    );
  }
}
