import 'package:dart_api/routes/auth_routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart'; // ← add this!

void main() async {
  final router = Router();

  router.mount('/api/v1/admin/auth', authRoute().call);

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final server = await io.serve(handler, 'localhost', 8080);
  print('Server running on http://localhost:${server.port}');
}
