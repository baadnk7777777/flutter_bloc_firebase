import 'package:package_info_plus/package_info_plus.dart';

abstract class UserSession {
  Future<void> loadSession();
  Future<void> clearSession();
  Future<void> saveSession(
    String accessToken,
    String refreshToken,
    String displayName,
    String email,
    String uid,
  );

  bool get valid;
  String get refreshToken;
  String get accessToken;
  String get displayName;
  String get email;
  String get uid;
  PackageInfo? get packageInfo;
}
