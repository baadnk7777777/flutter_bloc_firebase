import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/common/style/app_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpButton extends StatelessWidget {
  final String buttonName;
  const SignUpButton({super.key, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          width: 3,
          color: AppColors.ilacPalette4,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
      ),
      child: buttonName == "facebook"
          ? const Icon(
              FontAwesomeIcons.facebook,
              color: Colors.black,
              size: 30,
            )
          : buttonName == "twitter"
              ? const Icon(
                  FontAwesomeIcons.twitter,
                  color: Colors.black,
                  size: 30,
                )
              : const Icon(
                  FontAwesomeIcons.google,
                  color: Colors.black,
                  size: 30,
                ),
    );
  }
}
