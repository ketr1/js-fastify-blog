FROM node:20-bookworm AS base

WORKDIR /app

COPY package.json package-lock.json .npmrc ./
RUN npm ci

FROM base AS development

COPY . .

FROM base AS build

COPY . .
RUN npm run build
RUN npm prune --omit=dev

FROM node:20-bookworm-slim AS production

WORKDIR /app
ENV NODE_ENV=production

COPY --from=build /app/package.json ./package.json
COPY --from=build /app/package-lock.json ./package-lock.json
COPY --from=build /app/.sequelizerc ./.sequelizerc
COPY --from=build /app/config ./config
COPY --from=build /app/dist ./dist
COPY --from=build /app/server ./server
COPY --from=build /app/node_modules ./node_modules

EXPOSE 8080

CMD ["npm", "start"]
