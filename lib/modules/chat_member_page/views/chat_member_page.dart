import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc_firebase_2/common/core/user_session/user_session.dart';
import 'package:flutter_bloc_firebase_2/di/injector.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/bloc/chat_member/bloc/chat_member_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/models/room.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/models/roomArge.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/widgets/member_lists_views.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/widgets/members_search_field.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/models/message.dart';
import 'package:flutter_bloc_firebase_2/modules/landing_page/lading_page_import.dart';
import 'package:flutter_bloc_firebase_2/utils/hex_to_color.dart';

class ChatMemberPage extends StatefulWidget {
  const ChatMemberPage({super.key});

  @override
  State<ChatMemberPage> createState() => _ChatMemberPageState();
}

class _ChatMemberPageState extends State<ChatMemberPage> {
  List<Room> rooms = <Room>[];
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _bootstrip();
    });
  }

  Future<void> _bootstrip() async {
    Future.delayed(const Duration(seconds: 1));
    BlocProvider.of<ChatMemberBloc>(context)
        .add(FetchChatRoomsbyId(locator<UserSession>().uid));
  }

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
            Expanded(
              child: BlocConsumer<ChatMemberBloc, ChatMemberState>(
                listener: (context, state) {
                  rooms = state.rooms;
                },
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: rooms.length,
                    itemBuilder: (context, index) {
                      return MemberListsViws(
                        room: rooms[index],
                        lastMessage: rooms[index].message,
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
