let prisma;

try {
  const { PrismaClient } = require('@prisma/client');

  prisma = new PrismaClient({
    log:
        process.env.NODE_ENV === 'development'
            ? ['query', 'info', 'warn', 'error']
            : ['error'],
  });
} catch (e) {
  console.warn('Prisma désactivé ou non disponible, client mocké.');

  prisma = {
    $connect: async () => {},
    $disconnect: async () => {},
  };
}

module.exports = prisma;
