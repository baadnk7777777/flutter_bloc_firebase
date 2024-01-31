import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/modules/splash_page/splash_page_import.dart';

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
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _bootstrip();
    });
  }

  Future<void> _bootstrip() async {
    Future.delayed(const Duration(seconds: 1));
    final userSession = locator<UserSession>();
    await userSession.loadSession();
    print(userSession.uid);
    if (!mounted) return;
    if (userSession.valid) {
      Navigator.pushReplacementNamed(context, LandingPage.route);
      AppLogger.log('You are alreay loged.', 'bootstrap', '🎉');
      AppLogger.log('Navigator to LandingPage', 'Navigator', '🎉');
    } else {
      Navigator.pushReplacementNamed(context, GetStart.route);
      AppLogger.log('Please login before use.', 'bootstrap', '⚠️');
      AppLogger.log('Navigator to GetStartPage', 'Navigator', '🎉');
    }
    // AppLogger.logD(userSession.valid, 'bootstrap');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
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
