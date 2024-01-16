import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/style/app_color.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/form_bloc/bloc/form_bloc.dart';

class AgeField extends StatelessWidget {
  const AgeField({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: Colors.black54,
              fontFamily: "poppins",
              fontSize: 18,
            ),
            decoration: InputDecoration(
                prefixIcon: const Icon(CupertinoIcons.scope),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                helperText: 'Age must be valid, e.g. between 1 - 120',
                helperMaxLines: 1,
                labelText: 'Age',
                errorMaxLines: 1,
                errorText: !state.isAgeValid
                    ? 'Age must be valid, e.g. between 1 - 120'
                    : null,
                filled: true,
                fillColor: AppColors.ilacPalette3,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                )),
            onChanged: (value) {
              context.read<FormBloc>().add(AgeChanged(age: int.parse(value)));
            },
          ),
        );
      },
    );
  }
}
