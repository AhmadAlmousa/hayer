# Runtime secrets

Create these files locally; this directory is ignored except for this guide.

- `database_password`: the PostgreSQL password only, with no YAML syntax.
- `pgpass`: `postgres:5432:hayer:hayer:<database password>` and mode `0600`.
- `passwords.yaml`: copy the server `config/passwords.yaml.example`, replace
  every value needed in production, and ensure `production.database` matches
  `database_password`.
- `admin.htpasswd`: create one named operator with
  `htpasswd -B -c admin.htpasswd <operator>`.

The external reverse proxy should forward `https://hayer.almou.sa` to port
`8432` and preserve WebSocket upgrade headers.
