import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile extends Equatable {
  const UserProfile({
    required this.userKey,
    required this.userId,
    required this.customerId,
    required this.customerNo,
    required this.arDivisionNo,
    required this.customerKey,
    required this.fullName,
  });

  final int userKey;
  @JsonKey(name: 'userID')
  final String userId;
  @JsonKey(name: 'customerID')
  final String customerId;
  final String customerNo;
  final String arDivisionNo;
  final int customerKey;
  final String? fullName;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

  @override
  List<Object?> get props => [userKey, userId, customerId, customerNo, arDivisionNo, customerKey, fullName];
}
