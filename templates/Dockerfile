# syntax=docker/dockerfile:1.4
FROM node:20 AS base
RUN corepack enable && corepack prepare pnpm@9 --activate

FROM base AS deps
WORKDIR /app

ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV}

RUN git config --global url."git@172.16.150.150:".insteadOf "http://uj.git1.xiaohei123.fun:800/"

COPY package.json pnpm-lock.yaml ./

RUN mkdir -p /root/.ssh \
 && chmod 700 /root/.ssh \
 && ssh-keyscan -H 172.16.150.150 >> /root/.ssh/known_hosts

RUN --mount=type=ssh pnpm install --frozen-lockfile --ignore-scripts --registry=https://registry.npmmirror.com

FROM deps AS prod-deps
RUN pnpm prune --prod --ignore-scripts

FROM base AS build
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN pnpm run build

FROM node:20-alpine AS production

ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV}

RUN apk add --no-cache tzdata wget
ENV TZ=Asia/Shanghai

WORKDIR /app
COPY --from=prod-deps /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
COPY --from=build /app/config.*.json ./

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1:3000 || exit 1

CMD ["node", "./dist/main.js"]
