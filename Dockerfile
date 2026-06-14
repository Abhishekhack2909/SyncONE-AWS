### build the frontend[dist folder]
### we  doing this in a separate stage to keep the final image small and multipe prodction stages

FROM node:20-alpine as frontend-builder

COPY ./Frontend/vite-project /app

WORKDIR /app

RUN npm install

RUN npm run build

#### build for production
FROM node:20-alpine as backend-builder

COPY ./Backend /app

WORKDIR /app

RUN npm install

COPY --from=frontend-builder /app/dist /app/public

CMD ["node", "server.js"]






