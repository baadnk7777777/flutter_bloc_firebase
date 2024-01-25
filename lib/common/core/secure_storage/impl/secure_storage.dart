import 'package:flutter_bloc_firebase_2/common/core/secure_storage/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageImpl extends SecureStorage {
  static const _options = IOSOptions(
    // This options for IOS accessibility it means you can access the data after unlock.
    // and synchoronizable it data does't connect with ICLOID on IOS.
    accessibility: KeychainAccessibility.first_unlock,
    synchronizable: false,
  );

  final _storage = const FlutterSecureStorage();
  final String _namespace;

  SecureStorageImpl(this._namespace);

  String _getKey(String key) {
    return '{$_namespace}_{$key}';
  }

  @override
  Future<String?> read(String key) async {
    //Reading data from the SecureStorage by key but using private
    //methods for getkey before. and don't put direct key.
    final data = await _storage.read(key: _getKey(key));
    if (data == null) {
      return null;
    }
    return data;
  }

  @override
  Future<void> write(String key, String value) async {
    await _storage.write(
      key: _getKey(key),
      value: value,
      iOptions: _options,
    );
  }

  @override
  Future<void> delete(String key) async {
    _storage.delete(key: _getKey(key));
  }

  @override
  Future<void> deleteAll() async {
    _storage.deleteAll();
  }
}
