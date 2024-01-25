import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/views/chat_page.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/views/home_page.dart';
import 'package:flutter_bloc_firebase_2/modules/landing_page/bloc/landing/bloc/landing_page_bloc.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  List<BottomNavigationBarItem> bottomNavItems =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_outlined,
        color: Colors.black26,
      ),
      label: 'Home',
      backgroundColor: Colors.white,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.chat_bubble_outline,
        color: Colors.black26,
      ),
      label: 'Chats',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.notifications_outlined,
        color: Colors.black26,
      ),
      label: 'Notifications',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings_outlined,
        color: Colors.black26,
      ),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LandingPageBloc, LandingPageState>(
        builder: (context, state) {
          switch (state.navbarItem) {
            case NavbarItem.home:
              return const HomePage();

            case NavbarItem.chats:
              return const ChatPage();

            default:
              return Container();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<LandingPageBloc, LandingPageState>(
        builder: (context, state) {
          return BottomNavigationBar(
            fixedColor: Colors.grey,
            currentIndex: state.tabIndex,
            showUnselectedLabels: false,
            items: bottomNavItems,
            onTap: (index) {
              if (index == 0) {
                context.read<LandingPageBloc>().add(
                      TabChange(NavbarItem.home, tabIndex: 0),
                    );
              } else if (index == 1) {
                context.read<LandingPageBloc>().add(
                      TabChange(NavbarItem.chats, tabIndex: 1),
                    );
              }
            },
          );
        },
      ),
    );
  }
}
