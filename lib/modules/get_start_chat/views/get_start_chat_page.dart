import 'package:flutter/material.dart';

class GetStartChat extends StatelessWidget {
  static const String route = "get_start_chat";
  final VoidCallback? onPressed;
  const GetStartChat({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Container(
              width: double.infinity,
              height: 550,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(243, 16, 16, 1),
                  Color.fromRGBO(197, 16, 16, 1),
                ],
              )),
            ),
            Positioned(
              top: -100,
              left: -130,
              child: SizedBox(
                child: Image.asset('images/ellipse.png'),
              ),
            ),
            Positioned(
              top: 155,
              left: 16,
              width: 166,
              height: 166,
              child: SizedBox(
                child: Image.asset('images/ellipse.png'),
              ),
            ),
            Positioned(
              bottom: 80,
              right: 60,
              width: 135,
              height: 135,
              child: SizedBox(
                child: Image.asset('images/ellipse.png'),
              ),
            ),
            Positioned(
              top: -20,
              right: -60,
              child: SizedBox(
                child: Image.asset('images/ellipse.png'),
              ),
            ),
            Positioned(
              bottom: -195,
              left: 0,
              child: SizedBox(
                child: Image.asset('images/ellipse.png'),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.13,
              left: MediaQuery.of(context).size.width * 0.08,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "CHAT",
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Image.asset('images/get_start_chat.png'),
                ],
              ),
            ),
          ]),
          Expanded(
            child: Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Enjoy the new experience of",
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "chating with your friends.",
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Let’s start to chat right now .. ",
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(111, 111, 102, 1),
                        ),
                      ),
                      const SizedBox(height: 50),
                      InkWell(
                        onTap: onPressed,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.black,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 80,
                                  vertical: 20,
                                ),
                                child: Text(
                                  "Get start now",
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
