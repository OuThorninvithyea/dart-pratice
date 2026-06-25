import 'dart:convert';

import 'package:dart_api/models/auth_request.dart';
import 'package:dart_api/models/repository/repository.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

Router authRoute(UserRepository userRepository) {
  final router = Router();

  router.post('/login', (Request req) async {
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
    final errors = authRequest.validate();

    if (errors.isNotEmpty) {
      return Response.badRequest(
        body: jsonEncode({
          'message': 'Validation failed',
          'error': errors,
        })
      );
    }
    final user = await userRepository.findByUsernameAndPassword(
      authRequest.username,
      authRequest.password,
    );
    if (user != null) {
      return Response.ok(
        jsonEncode({
          'message': 'Login success',
          'username': user.username,
          'token': 'fake-token-123',
        }),
        headers: {'Content-Type': 'application/json'},
      );
    }
    return Response.forbidden(
      jsonEncode({'message': 'Invalid credentials'}),
      headers: {'Content-Type': 'application/json'},
    );
  });
  return router;
}
