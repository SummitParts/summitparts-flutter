import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<SecureStorageDataProvider>(
  (ref) => SecureStorageDataProvider(_flutterSecureStorage),
);

const FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(resetOnError: true, encryptedSharedPreferences: true),
  iOptions: IOSOptions(),
);

class SecureStorageDataProvider {
  SecureStorageDataProvider(this._flutterSecureStorage);

  final FlutterSecureStorage _flutterSecureStorage;

  Future<void> write({required String key, required String? value}) {
    return _flutterSecureStorage.write(key: key, value: value);
  }

  Future<String?> read({required String key}) {
    return _flutterSecureStorage.read(key: key);
  }

  Future<bool> containsKey({required String key}) {
    return _flutterSecureStorage.containsKey(key: key);
  }

  Future<void> delete({required String key}) {
    return _flutterSecureStorage.delete(key: key);
  }

  Future<void> deleteAll() {
    return _flutterSecureStorage.deleteAll();
  }
}
