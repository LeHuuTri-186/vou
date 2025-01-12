
class SignUpFormState {
  final String username;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String password;

  SignUpFormState({
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.email = '',
    this.password = '',
  });

  SignUpFormState copyWith({
    String? username,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? password,
  }) {
    return SignUpFormState(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}