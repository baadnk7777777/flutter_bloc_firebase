import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/constants/app_constants.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/bloc/form_bloc/bloc/login_form_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<LoginFormBloc, LoginFormState>(
          builder: (context, state) {
            if (state.status == StateStatus.success) {
              return Text(
                state.email,
                style: const TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                ),
              );
            } else {
              return const Text('loading');
            }
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.login_rounded),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          FlutterCarousel(
            items: [
              'images/banner_1.png',
              'images/banner_2.png',
              'images/banner_3.png',
            ].map((e) {
              return Builder(
                builder: (context) {
                  return Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      image: DecorationImage(
                        image: AssetImage(e),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 150.0,
              showIndicator: true,
              slideIndicator: const CircularSlideIndicator(),
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayCurve: Curves.easeInOut,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'ALL CATEGORIES',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Add your button press logic here
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.all(16), // Button color
                        ),
                        child: const Icon(
                          FontAwesomeIcons.pen, // Your desired icon
                          size: 30,
                          color: Colors.white, // Icon color
                        ),
                      ),
                      const Center(
                        child: Text("Repair"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/chatPage',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.all(16), // Button color
                        ),
                        child: const Icon(
                          FontAwesomeIcons.solidMessage, // Your desired icon
                          size: 30,
                          color: Colors.white, // Icon color
                        ),
                      ),
                      const Center(
                        child: Text("Chat"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
