import express, { Express, json, urlencoded } from 'express';
import { Sequelize } from 'sequelize';
import db from './models';
import usersRoutes from './routes/users';
import booksRoutes from './routes/books';

const app: Express = express();
const PORT = process.env.PORT || 3000;

// Sync All Models with DB
db.sequelize.sync({ force: false }).then(() => {
  console.log('Database & tables created!');
});

// Middleware to parse requests
app.use(json());
app.use(urlencoded({ extended: true }));

app.use('/users', usersRoutes);
app.use('/books', booksRoutes);

// Start server and establish connection to DB
app.listen(PORT, async () => {
  console.log(`Server is running on port ${PORT}`);
  try {
    await (db.sequelize as Sequelize).authenticate();
    console.log('Database connected');
  } catch (err) {
    console.log('Error connecting to database:', err);
  }
});
