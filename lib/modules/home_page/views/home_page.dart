import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/constants/app_constants.dart';
import 'package:flutter_bloc_firebase_2/common/style/app_color.dart';
import 'package:flutter_bloc_firebase_2/common/style/app_style.dart';
import 'package:flutter_bloc_firebase_2/modules/Login_page/bloc/form_bloc/bloc/login_form_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/bloc/message_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/models/message.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/widgets/custom_keyboard.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/auth_bloc/bloc/authentication_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/splash_page/splash_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final ScrollController _scrollController = ScrollController();
  List<Message> messagesList = <Message>[];
  String uId = '';
  @override
  void initState() {
    super.initState();
    // context.read<MessageBloc>().add(FetchMesageEvent());
    // BlocProvider.of<MessageBloc>(context).add(FetchMesageEvent());
  }

  @override
  void dispose() {
    // context.read<MessageBloc>().close();
    super.dispose();
  }

  TextEditingController mycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
      },
      buildWhen: (previous, current) {
        if (current is AuthenticationFailure) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: AppBar(
              backgroundColor: AppColors.ilacPalette4,
              automaticallyImplyLeading: false,
              title: const Text(
                'FriendName',
                style: TextStyle(
                    fontFamily: 'Popins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
          body: Column(
            children: [
              BlocBuilder<LoginFormBloc, LoginFormState>(
                builder: (context, state) {
                  if (state.status == StateStatus.success) {
                    uId = state.uid;
                  }
                  // return Text(state.uid);
                  return const SizedBox.shrink();
                },
              ),

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
                      return const LoadingPage();
                    } else if (state.status == StateStatus.success) {
                      messagesList = state.messagesList;
                      messagesList
                          .sort((a, b) => b.timestamp.compareTo(a.timestamp));
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
                            alignment: messagesList[index].uId == uId
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: messagesList[index].uId == uId
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.6,
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
                                        : const Color.fromRGBO(
                                            203, 203, 203, 0.2),
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

              // const Spacer(),
              CustomKeyboard(
                uId: uId,
              ),
              const SizedBox(
                height: 10,
              )
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     controller: mycontroller,
              //     decoration: InputDecoration(
              //       border: const OutlineInputBorder(),
              //       labelText: 'Message',
              //       suffixIcon: Padding(
              //         padding: const EdgeInsetsDirectional.only(end: 12.0),
              //         child: GestureDetector(
              //           child: const Icon(
              //             Icons.send_rounded,
              //             color: Colors.black,
              //           ),
              //           onTap: () {
              //             context.read<MessageBloc>().add(
              //                   SendMessageEvent(
              //                     message: mycontroller.text,
              //                     uId: uId,
              //                     chatId: 1,
              //                   ),
              //                 );

              //             mycontroller.clear();
              //           },
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
