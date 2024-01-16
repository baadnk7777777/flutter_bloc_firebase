import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/common/style/app_color.dart';

class SignUpField extends StatelessWidget {
  final String fieldType;
  final String hintText;
  final TextEditingController controller;
  // final Function(String) onTextChanged;

  const SignUpField(
      {super.key,
      required this.fieldType,
      required this.hintText,
      // required this.onTextChanged,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      // onChanged: onTextChanged,
      obscureText: fieldType == "email" ? false : true,
      obscuringCharacter: "*",
      style: const TextStyle(
        color: Colors.black54,
        fontFamily: "poppins",
        fontSize: 18,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
          right: 20,
        ),
        prefixIcon: fieldType == "email"
            ? const Icon(CupertinoIcons.mail_solid)
            : const Icon(CupertinoIcons.lock_fill),
        suffixIcon: fieldType == "password"
            ? const Icon(CupertinoIcons.eye_slash_fill)
            : const SizedBox.shrink(),
        hintText: hintText,
        filled: true,
        fillColor: AppColors.ilacPalette3,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
