FROM node:14-alpine AS build

WORKDIR /app
RUN echo "Working directory set to /app"

COPY package*.json ./
RUN npm install --silent
RUN echo "Dependencies installed"

COPY . .
RUN npm run build
RUN echo "Application built"


FROM node:14-alpine

ENV NODE_ENV=production
ENV PORT=3000
RUN echo "Set environment variables NODE_ENV=production and PORT=3000"

WORKDIR /app
COPY package*.json ./
RUN npm install --production --silent
RUN echo "Installed production dependencies"

COPY --from=build /app/build ./build
RUN npm test
RUN echo "Tests executed"

EXPOSE 3000
CMD ["npm", "start"]
RUN echo "Started the application"