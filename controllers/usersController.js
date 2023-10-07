const db = require("../models/index");
const { validationResult } = require('express-validator');

const createUser = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  try {
    const user = {
      name: req.body.name,
    };

    const data = await db.User.create(user);
    res.status(201).send(data); // Send back the created user
  } catch (err) {
    res.status(500).send({
      message: err.message || "Some error occurred while creating the User.",
    });
  }
};

const getUsers = async (req, res) => {
  try {
    const users = await db.User.findAll({
      attributes: ['id', 'name'] // Omit timestamps
    });
    res.status(200).json(users);
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: "An error occurred while trying to fetch users" });
  }
};

const getUser = async (req, res) => {
  try {
    const userId = parseInt(req.params.id, 10);
    if (isNaN(userId)) {
      return res.status(400).json({ error: 'User ID must be number' });
    }

    const user = await db.User.findByPk(userId);

    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    const transactions = await db.Transaction.findAll({
      where: { userId },
      include: db.Book
    });

    const pastBooks = transactions
      .filter(transaction => transaction.returnedAt !== null)
      .map(transaction => {
        return {
          name: transaction.Book.name,
          userScore: transaction.score
        };
      });

    const presentBooks = transactions
      .filter(transaction => transaction.returnedAt === null)
      .map(transaction => {
        return {
          name: transaction.Book.name
        };
      });

    const responseBody = {
      id: user.id,
      name: user.name,
      books: {
        past: pastBooks,
        present: presentBooks
      }
    };

    res.status(200).json(responseBody);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "An error occurred while trying to fetch user information" });
  }
};


module.exports = {
  createUser,
  getUsers,
  getUser
}
