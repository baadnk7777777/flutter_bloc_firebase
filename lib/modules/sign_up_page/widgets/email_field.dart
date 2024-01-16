import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/style/app_color.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/form_bloc/bloc/form_bloc.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});

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
              context.read<FormBloc>().add(EmailChanged(email: value));
            },
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.black54,
              fontFamily: "poppins",
              fontSize: 18,
            ),
            decoration: InputDecoration(
                prefixIcon: const Icon(CupertinoIcons.mail_solid),
                labelText: 'Email',
                helperText: 'A complete, valid email e.g. bank@email.com',
                errorText: !state.isNameValid
                    ? 'Please ensure the email is valid'
                    : null,
                hintText: 'Email',
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
