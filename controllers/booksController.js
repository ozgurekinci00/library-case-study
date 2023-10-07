const db = require("../models/index");
const { validationResult } = require('express-validator');
const { Op } = require('sequelize');

const createBook = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  try {
    const book = {
      name: req.body.name,
    };

    const data = await db.Book.create(book);
    res.status(201).send(data);
  } catch (err) {
    res.status(500).send({
      message: err.message || "Some error occurred while creating the Book.",
    });
  }
};

const getBooks = async (req, res) => {
  try {
    const books = await db.Book.findAll({
      attributes: ['id', 'name'] // Omit timestamps
    });
    res.status(200).json(books);
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: "An error occurred while trying to fetch books" });
  }
};

const getBook = async (req, res) => {
  try {
    const bookId = parseInt(req.params.id, 10);
    if (isNaN(bookId)) {
      return res.status(400).json({ error: 'Book ID must be a number' });
    }

    const book = await db.Book.findByPk(bookId);
    if (!book) {
      return res.status(404).json({ error: 'Book not found' });
    }

    // Fetch transactions related to the book
    const transactions = await db.Transaction.findAll({
      where: {
        bookId: bookId,
        score: { [Op.ne]: null }  // Only consider transactions where a score is given
      }
    });

    // Calculate the average score
    const totalScore = transactions.reduce((sum, transaction) => sum + transaction.score, 0);
    const averageScore = transactions.length > 0 ? (totalScore / transactions.length).toFixed(2) : -1;

    // Respond with the book data and average score
    res.status(200).json({
      id: book.id,
      name: book.name,
      score: averageScore
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

module.exports = {
  getBooks,
  createBook,
  getBook,
}
