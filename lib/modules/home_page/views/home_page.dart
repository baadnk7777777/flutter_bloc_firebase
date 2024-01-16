import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_2/common/constants/app_constants.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/bloc/message_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/home_page/models/message.dart';
import 'package:flutter_bloc_firebase_2/modules/sign_up_page/bloc/authentication_bloc.dart';
import 'package:flutter_bloc_firebase_2/modules/splash_page/splash_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final ScrollController _scrollController = ScrollController();
  // List<Message> messagesList = <Message>[];
  // int userId = 1;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoading) {
            const LoadingPage();
          } else if (state is AuthenticationFailure) {
            showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    content: Text('error'),
                  );
                });
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/chatPage',
                    );
                  },
                  child: const Text('ChatPage')),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(SignOut());
                  },
                  child: const Text('logOut')),
            ],
          );
        },
      ),
      // body: Column(
      //   children: [
      //     FloatingActionButton(onPressed: () {
      //       setState(() {
      //         userId = 2;
      //       });
      //     }),
      //     Expanded(
      //       child: BlocConsumer<MessageBloc, MessageState>(
      //         listener: (context, state) {
      //           if (state.status == StateStatus.loading &&
      //               messagesList.isNotEmpty) {}
      //           if (state.status == StateStatus.success &&
      //               messagesList.isEmpty) {}
      //           if (state.status == StateStatus.failure &&
      //               messagesList.isEmpty) {}
      //           return;
      //         },
      //         builder: (context, state) {
      //           if (state.status == StateStatus.initial ||
      //               (state.status == StateStatus.loading &&
      //                   messagesList.isEmpty)) {
      //             return const LoadingPage();
      //           } else if (state.status == StateStatus.success) {
      //             messagesList = state.messagesList;
      //             messagesList
      //                 .sort((a, b) => b.timestamp.compareTo(a.timestamp));
      //           } else if (state.status == StateStatus.failure &&
      //               messagesList.isEmpty) {}
      //           return ListView.builder(
      //             reverse: true,
      //             // controller: _scrollController,
      //             itemCount: messagesList.length,
      //             itemBuilder: (context, index) {
      //               return Align(
      //                 alignment: messagesList[index].userId != userId
      //                     ? Alignment.topRight
      //                     : Alignment.topLeft,
      //                 child: Container(
      //                   margin: const EdgeInsets.symmetric(
      //                       vertical: 10, horizontal: 15),
      //                   padding: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     color: messagesList[index].userId != userId
      //                         ? Colors.blue
      //                         : Colors.grey,
      //                     borderRadius: BorderRadius.circular(10),
      //                   ),
      //                   child: Text(
      //                     messagesList[index].text,
      //                     style: const TextStyle(
      //                       color: Colors.white,
      //                     ),
      //                   ),
      //                 ),
      //               );
      //             },
      //           );
      //         },
      //       ),
      //     ),

      //     // const Spacer(),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: TextField(
      //         controller: mycontroller,
      //         decoration: InputDecoration(
      //           border: const OutlineInputBorder(),
      //           labelText: 'Message',
      //           suffixIcon: Padding(
      //             padding: const EdgeInsetsDirectional.only(end: 12.0),
      //             child: GestureDetector(
      //               child: const Icon(
      //                 Icons.send_rounded,
      //                 color: Colors.black,
      //               ),
      //               onTap: () {
      //                 print("userId" + userId.toString());
      //                 context.read<MessageBloc>().add(
      //                       SendMessageEvent(
      //                           message: mycontroller.text, userId),
      //                     );

      //                 mycontroller.clear();
      //               },
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
