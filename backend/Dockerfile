FROM node:20-slim

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

RUN apt-get update -y && apt-get install -y openssl

COPY package*.json ./
RUN npm install

COPY . .

RUN npx prisma generate

EXPOSE 3000

CMD ["node", "src/index.js"]
