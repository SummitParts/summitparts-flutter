import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/constants/storage_constants.dart';
import 'package:summit_parts/core/data/local/in_memory_storage_data_provider.dart';
import 'package:summit_parts/core/data/local/secure_storage_data_provider.dart';
import 'package:summit_parts/features/auth/data/auth_data_provider.dart';
import 'package:summit_parts/features/auth/logic/user_provider.dart';
import 'package:summit_parts/features/auth/model/sign_in_response.dart';

final authNotifierProvider = AsyncNotifierProvider.autoDispose<AuthNotifier, SignInResponse?>(AuthNotifier.new);

class AuthNotifier extends AutoDisposeAsyncNotifier<SignInResponse?> {
  late final AuthDataProvider _authDataProvider = ref.read(authDataProvider);
  late final InMemoryStorageDataProvider _inMemoryStorageDataProvider = ref.read(inMemoryStorageProvider);
  late final SecureStorageDataProvider _secureStorageDataProvider = ref.read(secureStorageProvider);

  @override
  Future<SignInResponse?> build() async => null;

  Future<void> signIn(String email, String password) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final signInResponse = await _authDataProvider.signIn(email: email, password: password);
      _inMemoryStorageDataProvider.put(key: StorageConstants.accessTokenKey, value: signInResponse.accessToken);
      _inMemoryStorageDataProvider.put(key: StorageConstants.refreshTokenKey, value: signInResponse.refreshToken);
      await _secureStorageDataProvider.write(key: StorageConstants.accessTokenKey, value: signInResponse.accessToken);
      await _secureStorageDataProvider.write(key: StorageConstants.refreshTokenKey, value: signInResponse.refreshToken);
      ref.invalidate(userNotifierProvider);
      return signInResponse;
    });
  }
}
