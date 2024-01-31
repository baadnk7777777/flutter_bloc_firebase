import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc_firebase_2/common/core/user_session/user_session.dart';
import 'package:flutter_bloc_firebase_2/di/injector.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/chat_page_import.dart';
import 'package:flutter_bloc_firebase_2/modules/get_start_page/get_start_import.dart';

class ChatPage extends StatefulWidget {
  static const String route = 'chat_page';

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // final ScrollController _scrollController = ScrollController();
  List<Message> messagesList = <Message>[];
  String uId = '';
  @override
  void initState() {
    super.initState();
    final userSession = locator<UserSession>();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _bootstrip();
    });

    // context.read<MessageBloc>().add(FetchMesageEvent());
    // BlocProvider.of<MessageBloc>(context).add(FetchMesageEvent());
  }

  Future<void> _bootstrip() async {
    Future.delayed(const Duration(seconds: 1));
    final userSession = locator<UserSession>();
    await userSession.loadSession();
    locator<UserSession>().loadSession();
    setState(() {
      uId = locator<UserSession>().uid;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController mycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            width: double.infinity,
            height: 550,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(243, 16, 16, 1),
                Color.fromRGBO(197, 16, 16, 1),
              ],
            )),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              locator<UserSession>().uid == ''
                  ? 'Unknow'
                  : locator<UserSession>().displayName,
              style: const TextStyle(
                fontFamily: 'poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: _body());
  }

  Column _body() {
    return Column(
      children: [
        Expanded(
          child: BlocConsumer<MessageBloc, MessageState>(
            listener: (context, state) {
              if (state.status == StateStatus.loading &&
                  messagesList.isNotEmpty) {}
              if (state.status == StateStatus.success &&
                  messagesList.isEmpty) {}
              if (state.status == StateStatus.failure &&
                  messagesList.isEmpty) {}
              return;
            },
            builder: (context, state) {
              if (state.status == StateStatus.initial ||
                  (state.status == StateStatus.loading &&
                      messagesList.isEmpty)) {
                return const Center(child: LoadingWidget());
              } else if (state.status == StateStatus.success) {
                messagesList = state.messagesList;
                messagesList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
              } else if (state.status == StateStatus.failure &&
                  messagesList.isEmpty) {}
              return ListView.builder(
                reverse: true,
                // controller: _scrollController,
                itemCount: messagesList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Align(
                      alignment: messagesList[index].uId != uId
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: messagesList[index].uId != uId
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          messagesList[index].uId != uId
                              ? const CircleAvatar(
                                  backgroundColor: Colors.red,
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.6,
                            ),
                            margin: messagesList[index].uId == uId
                                ? const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, left: 8.0)
                                : const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8,
                                  ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15.0),
                            decoration: BoxDecoration(
                              color: messagesList[index].uId == uId
                                  ? const Color.fromRGBO(228, 0, 0, 1)
                                  : const Color.fromRGBO(203, 203, 203, 0.2),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            child: Text(
                              messagesList[index].text,
                              style: messagesList[index].uId == uId
                                  ? AppTextStyles.messageTextIsMe
                                  : AppTextStyles.messageTextNonIsMe,
                            ),
                          ),
                          Text(
                            DateFormat.Hm().format(messagesList[index]
                                .timestamp
                                .toDate()
                                .toLocal()),
                            style: const TextStyle(
                              fontFamily: 'Popins',
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: Color.fromRGBO(147, 147, 147, 1),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        CustomKeyboard(uId: uId),
      ],
    );
  }
}
