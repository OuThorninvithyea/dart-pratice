import 'package:postgres/postgres.dart';
import '/models/users.dart';
class UserRepository {
  final Pool db;

  UserRepository(this.db);

  Future<Users?> findByUsernameAndPassword( String username, String password) async {

    final result = await db.execute(
      Sql.named('''
        SELECT id, username
        FROM users
        WHERE username = @username
          AND password_hash = crypt(@password, password_hash)
          LIMIT 1
      '''),
      parameters: {
        'username': username,
        'password': password,
      },
    );

    if (result.isEmpty) {
      return null;
    }

    final row = result.first.toColumnMap();
    return Users(id: row['id'] as int , username: row['username'] as String,
    );
  }
}
