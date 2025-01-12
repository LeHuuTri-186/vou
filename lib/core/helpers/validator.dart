class FormValidators {
  /// Validates that the email is not empty and is in a valid format.
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates that the username is not empty and has at least 3 characters.
  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username cannot be empty';
    }
    if (username.length < 3) {
      return 'Username must be at least 3 characters long';
    }
    return null;
  }

  /// Validates that the first name is not empty and contains only letters.
  static String? validateFirstName(String? firstName) {
    if (firstName == null || firstName.isEmpty) {
      return 'First name cannot be empty';
    }
    final nameRegex = RegExp(r'^[a-zA-Z]+$');
    if (!nameRegex.hasMatch(firstName)) {
      return 'First name must contain only letters';
    }
    return null;
  }

  /// Validates that the last name is not empty and contains only letters.
  static String? validateLastName(String? lastName) {
    if (lastName == null || lastName.isEmpty) {
      return 'Last name cannot be empty';
    }
    final nameRegex = RegExp(r'^[a-zA-Z]+$');
    if (!nameRegex.hasMatch(lastName)) {
      return 'Last name must contain only letters';
    }
    return null;
  }

  /// Validates that the phone number is not empty and is in a valid format.
  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number cannot be empty';
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{10}$');
    if (!phoneRegex.hasMatch(phoneNumber)) {
      return 'Please enter a valid phone number (10 digits)';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    final upperCaseRegex = RegExp(r'[A-Z]');
    if (!upperCaseRegex.hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }
    final lowerCaseRegex = RegExp(r'[a-z]');
    if (!lowerCaseRegex.hasMatch(password)) {
      return 'Password must contain at least one lowercase letter';
    }
    final digitRegex = RegExp(r'[0-9]');
    if (!digitRegex.hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (!specialCharRegex.hasMatch(password)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
}
