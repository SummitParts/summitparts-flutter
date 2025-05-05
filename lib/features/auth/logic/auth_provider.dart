import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/features/auth/data/auth_data_provider.dart';
import 'package:summit_parts/features/auth/model/sign_in_response.dart';

final authNotifierProvider = AsyncNotifierProvider.autoDispose<AuthNotifier, SignInResponse?>(AuthNotifier.new);

class AuthNotifier extends AutoDisposeAsyncNotifier<SignInResponse?> {
  @override
  Future<SignInResponse?> build() async => null;

  Future<void> signIn(String email, String password) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(authDataProvider).signIn(email: email, password: password));
  }
}
