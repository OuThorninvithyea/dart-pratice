import 'dart:io';
import 'package:dart_api/routes/auth_routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:dart_api/models/repository/repository.dart';
import 'package:postgres/postgres.dart';

void main() async {
  final router = Router();

  final db = Pool.withEndpoints([
    Endpoint(
      host: Platform.environment['DB_HOST'] ?? 'localhost',
      port: int.tryParse(Platform.environment['DB_PORT'] ?? '') ?? 5432,
      database: Platform.environment['POSTGRES_DB'] ?? 'dart_api',
      username: Platform.environment['POSTGRES_USER'] ?? 'dart_api_user',
      password:
      Platform.environment['POSTGRES_PASSWORD'] ?? 'dart_api_password',
    ),
  ], settings: const PoolSettings(sslMode: SslMode.disable));
  final userRepository = UserRepository(db);

  router.mount('/api/v1/admin/auth', authRoute(userRepository).call);

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final port = int.tryParse(Platform.environment['PORT'] ?? '') ?? 3000;
  final host = Platform.environment['HOST'] ?? 'localhost';
  final server = await io.serve(handler, host, port);
  print('Server running on http://localhost:${server.port}');
}
