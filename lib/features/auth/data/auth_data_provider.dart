import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/data/http/dio_provider.dart';
import 'package:summit_parts/features/auth/model/sign_in_response.dart';
import 'package:summit_parts/features/auth/model/user_profile.dart';

final authDataProvider = Provider.autoDispose<AuthDataProvider>((ref) {
  return AuthDataProvider(ref.read(dioProvider));
});

class AuthDataProvider {
  const AuthDataProvider(this._dio);

  final Dio _dio;

  Future<SignInResponse> signIn({required String email, required String password}) async {
    final response = await _dio.post('/auth/login', data: {'userID': email, 'password': password});
    return SignInResponse.fromJson(response.data);
  }

  Future<void> signOut() async {
    await _dio.post('/auth/logout');
  }

  Future<UserProfile> getUserProfile() async {
    final response = await _dio.get('/user/profile');
    return UserProfile.fromJson(response.data);
  }
}
