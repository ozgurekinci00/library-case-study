import { Request, Response } from 'express';
import { validationResult } from 'express-validator';
import { Op } from 'sequelize';
import db from '../models/index';
import { NewBook, Book, Transaction } from '../interfaces';

export const createBook = async (req: Request, res: Response): Promise<void> => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    res.status(400).json({ errors: errors.array() });
    return;
  }

  try {
    const book: NewBook = {
      name: req.body.name,
    };

    await db.Book.create(book);
    res.status(201).send();
  } catch (err) {
    if (err instanceof Error) { // Type guard to get around TS error
      res.status(500).send({
        message: err.message || "Some error occurred while creating the Book.",
      });
    } else {
      res.status(500).send({
        message: "Some error occurred while creating the Book.",
      });
    }
  }
};

export const getBooks = async (req: Request, res: Response): Promise<void> => {
  try {
    const books: Book[] = await db.Book.findAll({
      attributes: ['id', 'name'] // Omit timestamps
    });
    res.status(200).json(books);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "An error occurred while trying to fetch books" });
  }
};

export const getBook = async (req: Request, res: Response): Promise<void> => {
  try {
    const bookId = parseInt(req.params.id, 10);
    if (isNaN(bookId)) {
      res.status(400).json({ error: 'Book ID must be a number' });
      return;
    }

    const book = await db.Book.findByPk(bookId);
    if (!book) {
      res.status(404).json({ error: 'Book not found' });
      return;
    }

    // Fetch transactions related to the book
    const transactions: Transaction[] = await db.Transaction.findAll({
      where: {
        bookId: bookId,
        score: { [Op.ne]: null }  // Only consider transactions where a score is given
      }
    });

    // Calculate the average score
    const totalScore = transactions.reduce((sum, transaction) => sum + (transaction.score || 0), 0);
    const averageScore = transactions.length > 0 ? (totalScore / transactions.length).toFixed(2) : '-1';

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
