import 'package:dart_api/models/validation_errors.dart';

class AuthRequest {
  final String username;
  final String password;

  AuthRequest(this.username, this.password);

  factory AuthRequest.fromJson(Map<String, dynamic> json) {
    return AuthRequest
        (
      json['username'] is String ? json['username'] as String : '',
        json['password'] is  String ? json['password'] as String : '',
    );
  }
  bool isUsernameEmpty() {
    return username.trim().isEmpty;
  }
  bool isPasswordEmpty() {
    return password.trim().isEmpty;
  }

  List<ValidationErrors> validate() {

    final errors = <ValidationErrors> [];

    if (username.isEmpty) {
      return [ValidationErrors(field: ValidationsField.username, message: 'Username cannot be empty')];
    } else if (username.length < 4) {
      return [ValidationErrors(field: ValidationsField.username, message: 'Username must be at least 4 characters')];
    }

    if (password.isEmpty) {
      return [ValidationErrors(field: ValidationsField.password, message: 'Password cannot be empty')];
    } else if (password.length < 6 ) {
      return [ValidationErrors(field: ValidationsField.password, message: 'Password must be at least 6 characters')];
    }
    return errors;
  }

}