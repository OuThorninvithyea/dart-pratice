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
  Map<String, dynamic> toJson() {
    return {'username': username, "password": password};
  }
}
