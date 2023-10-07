const db = require("../models/index");

const borrowBook = async (req, res) => {
  try {
    const userId = parseInt(req.params.userId, 10);
    const bookId = parseInt(req.params.bookId, 10);

    if (isNaN(userId) || isNaN(bookId)) {
      return res
        .status(400)
        .json({ error: "User ID and Book ID must be numbers" });
    }

    // Check if the book is already borrowed by someone
    const existingTransaction = await db.Transaction.findOne({
      where: {
        bookId: bookId,
        returnedAt: null,
      },
    });

    if (existingTransaction) {
      if (existingTransaction.dataValues.userId === userId) {
        return res
        .status(400)
        .json({ error: "User already has the book." });
      }
      return res
        .status(400)
        .json({ error: "Book is already borrowed by someone else" });
    }

    // Create a new transaction with the borrowedAt field set to the current time
    await db.Transaction.create({
      userId: userId,
      bookId: bookId,
      borrowedAt: new Date(),
      returnedAt: null,
      score: null,
    });

    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

const returnBook = async (req, res) => {
  try {
    const userId = parseInt(req.params.userId, 10);
    const bookId = parseInt(req.params.bookId, 10);
    const score = parseInt(req.body.score, 10);

    if (isNaN(userId) || isNaN(bookId) || isNaN(score)) {
      return res
        .status(400)
        .json({ error: "User ID, Book ID, and Score must be numbers" });
    }

    // Check if the user has the book
    const existingTransaction = await db.Transaction.findOne({
      where: {
        userId,
        bookId,
        returnedAt: null,
      },
    });

    if (existingTransaction === null) {
      return res.status(400).json({ error: "User does not have the book" });
    }

    // Update the transaction set the returnedAt field to the current time and the score
    await db.Transaction.update(
      {
        returnedAt: new Date(),
        score: score,
      },
      {
        where: {
          userId: userId,
          bookId: bookId,
          returnedAt: null, // Only update transactions that haven't been returned yet
        },
      }
    );

    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

const getTransactions = async (req, res) => {
  try {
    const transactions = await db.Transaction.findAll();
    res.status(200).json(transactions);
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: "An error occurred while trying to fetch transactions" });
  }
};

module.exports = {
  borrowBook,
  returnBook,
  getTransactions,
};
