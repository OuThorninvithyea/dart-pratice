class AuthRequest {
  final String username;
  final String password;

  AuthRequest(this.username, this.password);

  factory AuthRequest.fromJson(Map<String, dynamic> json) {
    return AuthRequest
        (json['username'] is  String ? json['username'] as String : '',
        json['password'] is  String ? json['password'] as String : '',
    );
  }
  bool isUsernameEmpty() {
    return username.trim().isNotEmpty;
  }
  bool isPasswordEmpty() {
    return password.trim().isEmpty;
  }

  List<String> validate() {
    final errors = <String>[];

    if (isUsernameEmpty() || isPasswordEmpty()) {
      errors.add('Username and password cannot be empty');
    }
    if (username
        .trim()
        .length < 4) {
      errors.add('Username must be at least 4 characters');
    }
    if (password.length < 6) {
      errors.add('Password must be at least 6 characters');
    }

    return errors;
  }
  Map<String, dynamic> toJson() {
    return {'username': username, "password": password};
  }
}
