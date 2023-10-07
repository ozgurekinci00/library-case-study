const express = require("express");
const bodyParser = require("body-parser");
const { sequelize } = require("./models");
const usersRoutes = require("./routes/users");
const booksRoutes = require("./routes/books");

const app = express();
const PORT = process.env.PORT || 3000;

const db = require("./models");
// Sync All Models with DB
db.sequelize.sync({ force: false }).then(() => {
  console.log("Database & tables created!");
});

// Middleware to parse requests
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use("/users", usersRoutes);
app.use("/books", booksRoutes);

// Start server and establish connection to DB
app.listen(PORT, async () => {
  console.log(`Server is running on port ${PORT}`);
  try {
    await sequelize.authenticate();
    console.log("Database connected");
  } catch (err) {
    console.log("Error connecting to database:", err);
  }
});
