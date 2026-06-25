CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO users (username, password_hash)
VALUES
  ('admin', crypt('admin123', gen_salt('bf'))),
  ('thorn', crypt('thorn123', gen_salt('bf'))),
  ('demo', crypt('demo123', gen_salt('bf'))),
  ('student', crypt('student123', gen_salt('bf'))),
  ('manager', crypt('manager123', gen_salt('bf')))
ON CONFLICT (username) DO NOTHING;
