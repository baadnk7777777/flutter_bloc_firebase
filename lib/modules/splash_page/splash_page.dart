import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/di/injector.dart';
import 'package:flutter_bloc_firebase_2/modules/chat_page/models/message.dart';
import 'package:flutter_bloc_firebase_2/network/firebase_network.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatefulWidget {
  static const String route = 'splash';
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  List<Message> listMessage = <Message>[];
  final FirebaseNetwork firestoreService = locator<FirebaseNetwork>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(onPressed: () async {
          print('object');
          List<Message> message = await firestoreService.getAllMessages();

          setState(() {
            listMessage = message;
          });
          print(listMessage);
        }),
        Container(
          child: Lottie.asset('images/loading.json'),
        ),
      ],
    );
  }
}

// class LoadingPage extends StatelessWidget {
//   static const String route = 'splash';
//   const LoadingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Message> listMessage = <Message>[];
//     final FirebaseNetwork firestoreService = locator<FirebaseNetwork>();

//     return Column(
//       children: [
//         FloatingActionButton(onPressed: () async {
//           print('object');
//           firestoreService.getAllMessages();
//           print(listMessage);
//         }),
//         Container(
//           child: Lottie.asset('images/loading.json'),
//         ),
//       ],
//     );
//   }
// }
