import 'package:package_info_plus/package_info_plus.dart';

abstract class UserSession {
  Future<void> loadSession();
  Future<void> clearSession();
  Future<void> saveSession(String accessToken, String refreshToken);

  bool get valid;
  String get refreshToken;
  String get accessToken;
  PackageInfo? get packageInfo;
}
