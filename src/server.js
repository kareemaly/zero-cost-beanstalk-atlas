const express = require("express");
const morgan = require("morgan");
const cors = require("cors");
const hpp = require("hpp");
const helmet = require("helmet");
const compression = require("compression");
const config = require("./config");
const { validateEnv } = require("./utils/validateEnv");
const { stream, logger } = require("./utils/logger");
const { errorMiddleware } = require("./middlewares/errorMiddleware");

validateEnv();

const app = express();

app.use(morgan(config.logFormat, { stream }));
app.use(cors());
app.use(hpp());
app.use(helmet());
app.use(compression());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(errorMiddleware);

app.use("/health", (req, res) => {
  res.status(200).json({ message: "OK", version: config.version });
});

app.listen(config.port, () => {
  logger.info(`Server is running on port ${config.port}`);
});
