class Auth {
  final String token;

  Auth(this.token);

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(json['token']);
  }

  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}
