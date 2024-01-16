import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/style/app_color.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/bloc/message_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/authentication_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/widgets/sign_up_button.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/widgets/sign_up_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SignUpField(
                    fieldType: 'email',
                    hintText: 'email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SignUpField(
                    fieldType: 'password',
                    hintText: 'password',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          print('On Forgot Password');
                        },
                        child: Text(
                          'Frogot password',
                          style: TextStyle(
                            color: AppColors.ilacPalette4,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
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
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    TextSpan(
                        text: 'Already have an Account ?',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontFamily: 'poppins',
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: AppColors.ilacPalette4,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SignUpButton(
                        buttonName: 'facebook',
                      ),
                      SignUpButton(
                        buttonName: 'twitter',
                      ),
                      SignUpButton(
                        buttonName: 'google',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
