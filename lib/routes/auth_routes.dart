import 'dart:convert';
import 'package:dart_api/models/auth_request.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../data/fake_user.dart';

Router authRoute() {
  final router = Router();
  router.post('/login', (Request req) async {
    // convert incomming byte to string first
    final body = await req.readAsString();

    Map<String, dynamic> json;
    try {
      json = jsonDecode(body) as Map<String, dynamic>;
    } catch (_) {
      return Response.badRequest(
        body: jsonEncode({'message': 'Invalid JSON body'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final authRequest = AuthRequest.fromJson(json);

    if (authRequest.username.trim().isEmpty) {
      return Response.badRequest(
        body: jsonEncode({'message': 'Username is required'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    if (authRequest.password.trim().isEmpty) {
      return Response.badRequest(
        body: jsonEncode({'message': 'Passowrd is requied'}),
        headers: {'Content-Type': 'application/json'},
      );
    }
    
    if (authRequest.username.length < 4) {
      return Response.badRequest(
        body: jsonEncode({'message': 'Username must be 4 charactes at leats'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    if (authRequest.password.length < 6) {
      return Response.badRequest(
        body: jsonEncode({
          'message': 'Password must be 6 characters at leatst',
        }),
        headers: {'Content-Type': 'application/json'},
      );
    }

    if (authRequest.username == FakeUser.serverUser['username'] &&
        authRequest.password == FakeUser.serverUser['password']) {
      return Response.ok(
        jsonEncode({
          'message': 'Login success',
          'username': authRequest.username,
          'token': 'fake-token-123',
        }),
        headers: {'Content-Type': 'application/json'},
      );
    }
    return Response.forbidden(
      jsonEncode({'message': 'Invalid credentails'}),
      headers: {'Content-Type': 'application/json'},
    );
  });
  return router;
}
