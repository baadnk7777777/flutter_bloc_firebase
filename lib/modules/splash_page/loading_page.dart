import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/modules/splash_page/splash_page_import.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset('images/loading.json'),
    );
  }
}
