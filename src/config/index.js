require("dotenv").config({
  path: `.env.${process.env.NODE_ENV}.local`
});

module.exports = {
  port: process.env.PORT,
  version: process.env.VERSION,
  logFormat: process.env.LOG_FORMAT
};
