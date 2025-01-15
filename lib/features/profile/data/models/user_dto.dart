import '../../domain/entities/user_model.dart';

class UserDto {
  final String username;
  final String id;
  final String accountId;
  final String firstName;
  final String lastName;
  final String? avatar;
  final String phone;
  final String email;
  final String? facebook;

  UserDto( {
    required this.username,
    required this.id,
    required this.accountId,
    required this.firstName,
    required this.lastName,
    this.avatar,
    required this.phone,
    required this.email,
    this.facebook,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      username: json['username'],
      id: (json['user']['id'] as int).toString(),
      accountId: json['user']['accountId'],
      firstName: json['user']['firstName'],
      lastName: json['user']['lastName'],
      avatar: json['user']['avatar'],
      phone: json['user']['phone'],
      email: json['user']['email'],
      facebook: json['user']['facebook'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
  User toDomain() {
    return User(
      username: username,
      id: id,
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
  static UserDto fromDomain(User user) {
    return UserDto(
      username: user.username,
      id: user.id,
      accountId: user.accountId,
      firstName: user.firstName,
      lastName: user.lastName,
      phone: user.phone,
      email: user.email,
    );
  }
}
