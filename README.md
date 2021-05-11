# AFABECC
A Fairly Abstract Backend Engineering Coding Challenge

A client can define mock endpoints with specified paths and static responses. And then they can consume them!
Say, you wanted to receive `{ 'good' : 'morning' }` from `GET /greeting`. Well, now you can.

# Local Setup

Start a PostgreSQL instance (uses default environment variables from `.env.development`).

```bash
$ docker-compose -f docker-compose.dev-db.yml up -d
```

Establish dev and test databases
```bash
$ rake db:create
$ rake db:migrate
```

Startup
```bash
$ rails c
```

# Development and test credentials
Use `.env.development.local` and `.env.test.local` to override correspondig env files.

AFABECC uses `.dotenv` so please refer to [its docs](https://github.com/bkeepers/dotenv#what-other-env-files-can-i-use) for details.
