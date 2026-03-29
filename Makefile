setup: install db-migrate

install:
	npm install

db-migrate:
	npm run migrate

build:
	npm run build

prepare-env:
	cp -n .env.example .env

start:
	NODE_ENV=production npm run start

dev:
	npm run dev

start-backend:
	npm run dev:server

start-frontend:
	npm run dev:assets

lint:
	npm run lint

lint-fix:
	npm run lint:fix

test:
	NODE_ENV=test npm test -s
