import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/modules/get_start_page/get_start_import.dart';

class GetStart extends StatelessWidget {
  static const String route = 'getStart';
  const GetStart({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: _body(context),
    // );
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              Future.delayed(const Duration(seconds: 10), () {
                return const LoadingWidget();
              });
            } else if (snapshot.hasData) {
              // ยิง get data from preferences.
              BlocProvider.of<LoginFormBloc>(context).add(const GetData());
              // Navigator.pushReplacementNamed(context, LandingPage.route);
              // return LandingPage();
            } else if (snapshot.hasError) {
              Container(
                child: const Text('Error'),
              );
            }
            return _body(context);
          }),
    );
  }

  Expanded _body(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.getStartBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/getStart_bg.png'),
            const SizedBox(
              height: 100,
            ),
            const Text(
              'Professional Service',
              style: TextStyle(
                fontFamily: 'poppins',
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Now Book all your Solar related services at a click.',
                style: TextStyle(
                  fontFamily: 'poppins',
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, LoginPage.route);
                      AppLogger.log(
                          'Navigator to LoginPagePage', 'Navigator', '🎉');
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: 30,
                          right: 30,
                        ),
                        child: Center(
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'poppins',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: 30,
                          right: 30,
                        ),
                        child: Center(
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'poppins',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
