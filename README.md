A sample Dart API with an entrypoint in `bin/`, library code in `lib/`, and
PostgreSQL available through Docker.

## Dart API

Run the API:

```sh
dart run bin/main.dart
```

The API uses port `3000` by default:

```text
http://localhost:3000
```

Override the API port when needed:

```sh
PORT=8081 dart run bin/main.dart
```

## PostgreSQL with Docker

Copy the example environment file:

```sh
cp .env.example .env
```

Start the API, PostgreSQL, and pgAdmin:

```sh
docker compose up -d
```

The Docker services expose:

```text
Dart API: http://localhost:3000
PostgreSQL: localhost:5432
pgAdmin: http://localhost:5050
```

Open pgAdmin in your browser:

```text
http://localhost:5050
```

Login to pgAdmin:

```text
Email: admin@example.com
Password: admin123
```

Register the PostgreSQL server in pgAdmin with:

```text
Host name/address: postgres
Port: 5432
Maintenance database: dart_api
Username: dart_api_user
Password: dart_api_password
```

Important: if pgAdmin is running in Docker, do not use `localhost` as the
PostgreSQL host. Use `postgres`, because that is the service name inside the
Docker network.

Open a PostgreSQL shell inside the container:

```sh
docker exec -it dart_api_postgres psql -U dart_api_user -d dart_api
```

Check the created tables:

```sql
\dt
```

The database starts with these mock users:

```text
admin / admin123
thorn / thorn123
demo / demo123
student / student123
manager / manager123
```

Stop the database:

```sh
docker compose down
```

Remove the database data volume and start fresh:

```sh
docker compose down -v
```
