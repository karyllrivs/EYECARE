const express = require("express");
const http = require("http");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const compression = require("compression");
const cors = require("cors");
const { config } = require("dotenv");
const mongoose = require("mongoose");
const routers = require("../src/routers/index.js");

config();
const { PORT, MONGODB_URI, MONGODB_NAME, FRONTEND_URL  } = process.env;

const app = express();

app.use(
  cors({
    credentials: true,
    origin: FRONTEND_URL,
  })
);

app.use(compression());
app.use(cookieParser());
app.use(bodyParser.json());
app.use("/api", routers());

mongoose.Promise = Promise;
mongoose
  .connect(MONGODB_URI, { dbName: MONGODB_NAME })
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((error) => console.error("Error connecting to MongoDB:", error));

const server = http.createServer(app);

server.listen(PORT, () => {
  console.log("Server running on http://localhost:" + PORT);
});

module.exports = app;