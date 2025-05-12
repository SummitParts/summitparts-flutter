import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/constants/storage_constants.dart';
import 'package:summit_parts/core/data/local/in_memory_storage_data_provider.dart';
import 'package:summit_parts/core/data/local/secure_storage_data_provider.dart';
import 'package:summit_parts/features/auth/model/sign_in_response.dart';

final userNotifierProvider = AsyncNotifierProvider.autoDispose<UserNotifier, SignInResponse?>(UserNotifier.new);

class UserNotifier extends AutoDisposeAsyncNotifier<SignInResponse?> {
  late final InMemoryStorageDataProvider _inMemoryStorageDataProvider = ref.read(inMemoryStorageProvider);
  late final SecureStorageDataProvider _secureStorageDataProvider = ref.read(secureStorageProvider);

  @override
  Future<SignInResponse?> build() async {
    final accessToken = await _secureStorageDataProvider.read(key: StorageConstants.accessTokenKey);
    final refreshToken = await _secureStorageDataProvider.read(key: StorageConstants.refreshTokenKey);
    if (accessToken != null && refreshToken != null) {
      _inMemoryStorageDataProvider.put(key: StorageConstants.accessTokenKey, value: accessToken);
      _inMemoryStorageDataProvider.put(key: StorageConstants.refreshTokenKey, value: refreshToken);
      return SignInResponse(accessToken: accessToken, refreshToken: refreshToken);
    }
    return null;
  }

  void signOut() {
    _secureStorageDataProvider.delete(key: StorageConstants.accessTokenKey);
    _secureStorageDataProvider.delete(key: StorageConstants.refreshTokenKey);
    _inMemoryStorageDataProvider.delete(key: StorageConstants.accessTokenKey);
    _inMemoryStorageDataProvider.delete(key: StorageConstants.refreshTokenKey);
    state = const AsyncData(null);
  }
}
