class AuthRequest {
  final String username;
  final String password;

  AuthRequest(this.username, this.password);

  factory AuthRequest.fromJson(Map<String, dynamic> json) {
    return AuthRequest(json['username'], json['password']);
  }
  
  Map<String, dynamic> toJson() {
    return {'username': username, "password": password};
  }
}
