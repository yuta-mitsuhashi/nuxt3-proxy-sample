FROM node:18.16.0-bullseye-slim as modules
WORKDIR /nuxt3-proxy-sample
COPY package.json package.json
COPY package-lock.json package-lock.json

RUN npm install

FROM node:18.16.0-bullseye-slim as builder

WORKDIR /nuxt3-proxy-sample
COPY . .
COPY --from=modules /nuxt3-proxy-sample/node_modules ./node_modules

RUN npm run build

FROM node:18.16.0-bullseye-slim as runtime

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
    tini \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /nuxt3-proxy-sample
COPY --from=builder /nuxt3-proxy-sample/.output .output

ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

EXPOSE 3000
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["node", "/nuxt3-proxy-sample/.output/server/index.mjs"]
