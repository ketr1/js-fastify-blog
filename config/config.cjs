require('dotenv').config();

const postgresConfig = {
  dialect: 'postgres',
  database: process.env.DATABASE_NAME,
  username: process.env.DATABASE_USERNAME,
  password: process.env.DATABASE_PASSWORD,
  port: process.env.DATABASE_PORT,
  host: process.env.DATABASE_HOST,
};

const shouldUsePostgresInDevelopment = Boolean(
  process.env.DATABASE_HOST
  && process.env.DATABASE_NAME
  && process.env.DATABASE_USERNAME,
);

module.exports = {
  development: shouldUsePostgresInDevelopment
    ? postgresConfig
    : {
        dialect: 'sqlite',
        storage: './database.sqlite',
      },
  production: postgresConfig,
  test: {
    dialect: 'sqlite',
    storage: './database.test.sqlite',
  },
};
