import 'package:flutter_bloc_firebase_2/common/core/secure_storage/secure_storage.dart';
import 'package:flutter_bloc_firebase_2/common/core/user_session/user_session.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UserSessionImpl implements UserSession {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _displayNameKey = 'display_name';
  static const _emailKey = 'email';
  static const _uidKey = 'uid';

  // => defined SecureStore in secure_storage file.
  final SecureStorage _secureStorage;
  String? _accessToken;
  String? _refreshToken;
  String? _displayName;
  String? _email;
  String? _uid;
  PackageInfo? _packageInfo;
  UserSessionImpl(this._secureStorage);

  @override
  Future<void> clearSession() async {
    _accessToken = null;
    _refreshToken = null;
    _displayName = null;
    _email = null;
    _uid = null;
    await _secureStorage.delete(_accessTokenKey);
    await _secureStorage.delete(_refreshTokenKey);
    await _secureStorage.delete(_displayNameKey);
    await _secureStorage.delete(_emailKey);
    await _secureStorage.delete(_uidKey);
  }

  @override
  Future<void> loadSession() async {
    _accessToken = await _secureStorage.read(_accessTokenKey);
    _refreshToken = await _secureStorage.read(_refreshTokenKey);
    _packageInfo = await PackageInfo.fromPlatform();
  }

  @override
  String get displayName => _displayName ?? '';

  @override
  String get email => _email ?? '';

  @override
  String get uid => _uid ?? '';

  @override
  String get accessToken => _accessToken ?? '';

  @override
  PackageInfo? get packageInfo => _packageInfo;

  @override
  String get refreshToken => _refreshToken ?? '';

  @override
  Future<void> saveSession(
    String accessToken,
    String refreshToken,
    String displayName,
    String email,
    String uid,
  ) async {
    if (accessToken == '' || refreshToken == '') return;

    try {
      _accessToken = accessToken;
      _refreshToken = refreshToken;
      _displayName = displayName;
      _email = email;
      _uid = uid;
      await _secureStorage.write(_accessTokenKey, accessToken);
      await _secureStorage.write(_refreshTokenKey, refreshToken);
      await _secureStorage.write(_displayNameKey, displayName);
      await _secureStorage.write(_emailKey, email);
      await _secureStorage.write(_uidKey, uid);
    } catch (_) {}
  }

  @override
  bool get valid => _accessToken != null && _accessToken != '';
}
