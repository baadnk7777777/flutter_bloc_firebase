import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/modules/get_start_chat/views/get_start_chat_page.dart';
import 'package:flutter_bloc_firebase_2/modules/landing_page/lading_page_import.dart';

class LandingPage extends StatefulWidget {
  static const String route = 'landing';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool getStart = true;
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
              return getStart
                  ? GetStartChat(
                      onPressed: () {
                        setState(() {
                          getStart = false;
                        });
                      },
                    )
                  : const ChatPage();

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
