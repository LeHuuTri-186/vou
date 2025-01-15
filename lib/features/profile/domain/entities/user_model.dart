class User {
  final String username;
  final String id;
  final String accountId;
  final String firstName;
  final String lastName;
  final String? avatar;
  final String phone;
  final String email;
  final String? facebook;

  User({
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
}
