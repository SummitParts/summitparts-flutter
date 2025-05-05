import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_response.g.dart';

@JsonSerializable()
class SignInResponse extends Equatable {
  const SignInResponse({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => _$SignInResponseFromJson(json);

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
