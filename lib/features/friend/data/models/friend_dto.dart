import '../../domain/entities/friend.dart';

class FriendDto {
  final String accountId;
  final String firstName;
  final String lastName;
  final String? avatar;
  final String phone;
  final String email;
  final String? facebook;

  FriendDto({
    required this.accountId,
    required this.firstName,
    required this.lastName,
    this.avatar,
    required this.phone,
    required this.email,
    this.facebook,
  });

  // Convert JSON to UserDto
  factory FriendDto.fromJson(Map<String, dynamic> json) {
    return FriendDto(
      accountId: json['accountId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String,
      email: json['email'] as String,
      facebook: json['facebook'] as String?,
    );
  }

  // Convert UserDto to JSON
  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
      'phone': phone,
      'email': email,
      'facebook': facebook,
    };
  }

  // Convert UserDto to User (Entity)
  Friend toDomain() {
    return Friend(
      accountId: accountId,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      phone: phone,
      email: email,
      facebook: facebook,
    );
  }

  // Convert User (Entity) to UserDto
  static FriendDto fromDomain(Friend user) {
    return FriendDto(
      accountId: user.accountId,
      firstName: user.firstName,
      lastName: user.lastName,
      avatar: user.avatar,
      phone: user.phone,
      email: user.email,
      facebook: user.facebook,
    );
  }
}
