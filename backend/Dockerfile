FROM node:20-slim

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

COPY package*.json ./
RUN npm ci

# On copie tout sauf node_modules Prisma (on va le virer après)
COPY . .

# Désactive Prisma en renommant le dossier .prisma pour ce build
RUN if [ -d "node_modules/@prisma" ]; then mv node_modules/@prisma node_modules/@prisma_disabled; fi

EXPOSE 3000

CMD ["node", "src/index.js"]
