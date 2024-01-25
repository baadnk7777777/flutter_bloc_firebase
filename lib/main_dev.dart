import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase_2/common/config/app_configs.dart';
import 'package:flutter_bloc_firebase_2/main.dart';

void main() {
  run(
    const Config(
      supportedLocales: [
        Locale('en', ''),
        Locale('th', ''),
      ],
      fallbackLocale: Locale('en', ''),
    ),
  );
}
