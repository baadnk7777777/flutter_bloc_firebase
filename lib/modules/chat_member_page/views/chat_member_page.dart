import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/widgets/member_lists_views.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/widgets/members_search_field.dart';
import 'package:flutter_bloc_firebase_2/modules/landing_page/lading_page_import.dart';
import 'package:flutter_bloc_firebase_2/utils/hex_to_color.dart';

class ChatMemberPage extends StatefulWidget {
  const ChatMemberPage({super.key});

  @override
  State<ChatMemberPage> createState() => _ChatMemberPageState();
}

class _ChatMemberPageState extends State<ChatMemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: 100,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(243, 16, 16, 1),
                Color.fromRGBO(197, 16, 16, 1),
              ],
            ),
          ),
        ),
        title: const Center(
          child: Text(
            'Chat',
            style: TextStyle(
              fontFamily: 'poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            const MembersSearchField(),
            // InkWell(
            //   onTap: () {
            //     Navigator.pushNamed(
            //       context,
            //       ChatPage.route,
            //     );
            //   },
            //   child: const Text('Chat'),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return MemberListsViws(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ChatPage.route,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
