import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/models/room.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_member_page/models/roomArge.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/models/message.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/views/chat_page.dart';
import 'package:flutter_bloc_firebase_2/utils/hex_to_color.dart';

class MemberListsViws extends StatelessWidget {
  // final VoidCallback? onPressed;
  final Room room;
  final Message lastMessage;
  const MemberListsViws({
    super.key,
    // this.onPressed,
    required this.room,
    required this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ChatPage.route,
          arguments: RoomArgs(chatRoomId: room.chatId),
        );
      },
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.red,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(room.chatId.toString()),
                      Text(lastMessage.text),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.Hm()
                        .format(lastMessage.timestamp.toDate().toLocal()),
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: ColorExtension("6F6F66"),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 20,
                      maxHeight: 31,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: ColorExtension("E40000"),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '999+',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
