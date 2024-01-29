import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/login_page_import.dart';

class LoginPage extends StatelessWidget {
  static const String route = 'login';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginFormBloc, LoginFormState>(
      listener: (context, state) {
        if (state.status == StateStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LandingPage.route,
            (route) => false,
          );
        } else if (state.status == StateStatus.loading) {
          const LoadingWidget();
        } else if (state.status == StateStatus.failure &&
            (state.email.isNotEmpty && state.password.isNotEmpty)) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Have something wrong"),
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.ilacPalette4,
        ),
        body: SingleChildScrollView(
          child: Expanded(
              child: Container(
            color: AppColors.ilacPalette4,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 30),
            height: MediaQuery.of(context).size.height,
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
                      Center(
                        child: LoginForm(),
                      ),
                    ],
                  )),
            ),
          )),
        ),
      ),
      // child: Scaffold(
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
      //         child: const Padding(
      //             padding: EdgeInsets.symmetric(
      //               vertical: 50,
      //               horizontal: 30,
      //             ),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 Padding(
      //                   padding: EdgeInsets.symmetric(
      //                     horizontal: 10,
      //                   ),
      //                   child: Text(
      //                     "Login",
      //                     style: TextStyle(
      //                       fontFamily: 'poppins',
      //                       fontWeight: FontWeight.w600,
      //                       fontSize: 30,
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: 30,
      //                 ),
      //                 EmailField(),
      //                 SizedBox(
      //                   height: 30,
      //                 ),
      //                 PasswordField(),
      //                 SizedBox(
      //                   height: 30,
      //                 ),
      //                 Center(child: LoginForm()),
      //               ],
      //             )),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
