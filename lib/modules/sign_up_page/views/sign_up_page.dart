import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/style/app_color.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/auth_bloc/bloc/authentication_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/form_bloc/bloc/form_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/widgets/age_field.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/widgets/display_name_field.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/widgets/email_field.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/widgets/error_dialog.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/widgets/password_field.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/widgets/sign_up_button.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/widgets/sign_up_field.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/widgets/submit_form.dart';

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
    // void onTextChanged(String newText, String fieldText) {
    //   print('newText: $newText $fieldText');
    // }
    return MultiBlocListener(
        listeners: [
          BlocListener<FormBloc, FormsValidate>(
            listener: (context, state) {
              if (state.errorMessage!.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ErrorDialog(errorMessage: state.errorMessage);
                  },
                );
              } else if (state.isFormValid && !state.isLoading) {
                context.read<AuthenticationBloc>().add(AuthenticationStarted());
                context.read<FormBloc>().add(const FormSucceeded());
              } else if (state.isFormValidateFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('isFormValidateFailed')));
              }
            },
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationSuccess) {
                Navigator.of(context).pushNamed(
                  '/login',
                );
              }
            },
          )
        ],
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

                      // THRERE: INPUTFIELD.
                      const EmailField(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      const PasswordField(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      const DisPlayNameField(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      const AgeField(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),

                      const Center(child: SubmitForm()),
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
                      // BlocConsumer<AuthenticationBloc, AuthenticationState>(
                      //   listener: (context, state) {
                      //     if (state is AuthenticationSuccess) {
                      //       // Navigator.of(context).pushReplacementNamed('/homePage');
                      //       Navigator.pushNamedAndRemoveUntil(
                      //           context, '/homePage', (route) => false);
                      //     } else if (state is AuthenticationFailure) {
                      //       showDialog(
                      //           context: context,
                      //           builder: (context) {
                      //             return const AlertDialog(
                      //               content: Text('error'),
                      //             );
                      //           });
                      //     }
                      //   },
                      //   builder: (context, state) {
                      //     return Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         state is AuthenticationLoading
                      //             ? const LoadingPage()
                      //             : ElevatedButton(
                      //                 onPressed: () {
                      //                   BlocProvider.of<AuthenticationBloc>(context)
                      //                       .add(
                      //                     SignUpUser(
                      //                       email: emailController.text.trim(),
                      //                       password:
                      //                           passwordController.text.trim(),
                      //                     ),
                      //                   );
                      //                   emailController.clear();
                      //                   passwordController.clear();
                      //                 },
                      //                 style: ElevatedButton.styleFrom(
                      //                     backgroundColor: AppColors.ilacPalette4),
                      //                 child: const Text(
                      //                   'Sign Up',
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.normal,
                      //                     fontFamily: 'poppins',
                      //                     fontSize: 20,
                      //                   ),
                      //                 ),
                      //               ),
                      //       ],
                      //     );
                      //   },
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an Account ?',
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'poppins',
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                context.read<FormBloc>().add(
                                    const FormSubmitted(value: Status.signIn));
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: AppColors.ilacPalette4,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins',
                                ),
                              ))
                        ],
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
        ));
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: AppColors.ilacPalette4,
    //   ),
    //   body: SingleChildScrollView(
    //     child: Container(
    //       color: AppColors.ilacPalette4,
    //       padding: const EdgeInsets.only(top: 30),
    //       child: Container(
    //         width: MediaQuery.of(context).size.width,
    //         decoration: const BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(50),
    //             topRight: Radius.circular(50),
    //           ),
    //         ),
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(
    //             vertical: 50,
    //             horizontal: 30,
    //           ),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               const Padding(
    //                 padding: EdgeInsets.symmetric(
    //                   horizontal: 10,
    //                 ),
    //                 child: Text(
    //                   "Sign Up",
    //                   style: TextStyle(
    //                     fontFamily: 'poppins',
    //                     fontWeight: FontWeight.w600,
    //                     fontSize: 30,
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 30,
    //               ),
    //               SignUpField(
    //                 controller: emailController,
    //                 // onTextChanged: (newText) {
    //                 //   onTextChanged(newText, 'email');
    //                 // },
    //                 fieldType: 'email',
    //                 hintText: 'email',
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               SignUpField(
    //                 controller: passwordController,
    //                 // onTextChanged: (newText) {
    //                 //   onTextChanged(newText, 'password');
    //                 // },
    //                 fieldType: 'password',
    //                 hintText: 'password',
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 children: [
    //                   TextButton(
    //                     onPressed: () {
    //                       print('On Forgot Password');
    //                     },
    //                     child: Text(
    //                       'Frogot password',
    //                       style: TextStyle(
    //                         color: AppColors.ilacPalette4,
    //                         fontWeight: FontWeight.w600,
    //                         fontFamily: 'poppins',
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               BlocConsumer<AuthenticationBloc, AuthenticationState>(
    //                 listener: (context, state) {
    //                   if (state is AuthenticationSuccess) {
    //                     // Navigator.of(context).pushReplacementNamed('/homePage');
    //                     Navigator.pushNamedAndRemoveUntil(
    //                         context, '/homePage', (route) => false);
    //                   } else if (state is AuthenticationFailure) {
    //                     showDialog(
    //                         context: context,
    //                         builder: (context) {
    //                           return const AlertDialog(
    //                             content: Text('error'),
    //                           );
    //                         });
    //                   }
    //                 },
    //                 builder: (context, state) {
    //                   return Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       state is AuthenticationLoading
    //                           ? const LoadingPage()
    //                           : ElevatedButton(
    //                               onPressed: () {
    //                                 BlocProvider.of<AuthenticationBloc>(context)
    //                                     .add(
    //                                   SignUpUser(
    //                                     email: emailController.text.trim(),
    //                                     password:
    //                                         passwordController.text.trim(),
    //                                   ),
    //                                 );
    //                                 emailController.clear();
    //                                 passwordController.clear();
    //                               },
    //                               style: ElevatedButton.styleFrom(
    //                                   backgroundColor: AppColors.ilacPalette4),
    //                               child: const Text(
    //                                 'Sign Up',
    //                                 style: TextStyle(
    //                                   color: Colors.white,
    //                                   fontWeight: FontWeight.normal,
    //                                   fontFamily: 'poppins',
    //                                   fontSize: 20,
    //                                 ),
    //                               ),
    //                             ),
    //                     ],
    //                   );
    //                 },
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   const Text(
    //                     'Already have an Account ?',
    //                     style: TextStyle(
    //                       color: Colors.black54,
    //                       fontFamily: 'poppins',
    //                     ),
    //                   ),
    //                   TextButton(
    //                       onPressed: () {
    //                         print("sign in");
    //                       },
    //                       child: Text(
    //                         'Sign In',
    //                         style: TextStyle(
    //                           color: AppColors.ilacPalette4,
    //                           fontWeight: FontWeight.bold,
    //                           fontFamily: 'poppins',
    //                         ),
    //                       ))
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               const Row(
    //                 children: <Widget>[
    //                   Expanded(
    //                     child: Divider(),
    //                   ),
    //                   SizedBox(
    //                     width: 10,
    //                   ),
    //                   Text(
    //                     'OR',
    //                     style: TextStyle(
    //                       fontSize: 18,
    //                       fontFamily: 'poppins',
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     width: 10,
    //                   ),
    //                   Expanded(
    //                     child: Divider(),
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               const Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   SignUpButton(
    //                     buttonName: 'facebook',
    //                   ),
    //                   SignUpButton(
    //                     buttonName: 'twitter',
    //                   ),
    //                   SignUpButton(
    //                     buttonName: 'google',
    //                   ),
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
