# JS Fastify Blog

[![Main](https://github.com/ketr1/js-fastify-blog/actions/workflows/main.yml/badge.svg)](https://github.com/ketr1/js-fastify-blog/actions/workflows/main.yml)

## Requirements

- Docker
- Docker Compose

## Environment

Create a local `.env` file before the first start:

```bash
cp .env.example .env
```

Default values are already prepared for local Docker Compose:

```dotenv
DATABASE_NAME=postgres
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=postgres
DATABASE_PORT=5432
DATABASE_HOST=localhost
```

`docker-compose.yml` overrides `DATABASE_HOST` to `db` inside containers, so the same `.env` file works both locally and in Docker.

## Local development with Docker Compose

Start the app and PostgreSQL:

```bash
docker compose up --build app db
```

The application will be available at `http://localhost:8080`.

## Checks in Docker

Run lint:

```bash
docker compose --profile ci run --rm lint
```

Run tests:

```bash
docker compose --profile ci run --rm test
```

After the checks finish, stop and clean up the services if needed:

```bash
docker compose down --volumes --remove-orphans
```

## Production image

Build the image:

```bash
docker build --target production -t <dockerhub-user>/js-fastify-blog:latest .
```

Run the container against PostgreSQL:

```bash
docker run --rm -p 8080:8080 --env-file .env -e DATABASE_HOST=host.docker.internal <dockerhub-user>/js-fastify-blog:latest
```

For container-to-container networking, pass `DATABASE_HOST` explicitly, for example `-e DATABASE_HOST=db`.

## GitHub Actions and Docker Hub

CI and image publishing are configured in [.github/workflows/main.yml](/c:/Users/kettr/.vscode/js-fastify-blog/.github/workflows/main.yml).

To publish the image to Docker Hub from GitHub Actions, configure these repository secrets:

- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`

The workflow publishes the image as `<repository_owner>/<repository_name>` by default on pushes to `main`.
