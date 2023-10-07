import { Request, Response } from 'express';
import db from '../models/index';
import { Transaction as TransactionType } from '../interfaces';

export const borrowBook = async (req: Request, res: Response): Promise<void> => {
  try {
    const userId = parseInt(req.params.userId, 10);
    const bookId = parseInt(req.params.bookId, 10);

    if (isNaN(userId) || isNaN(bookId)) {
      res.status(400).json({ error: "User ID and Book ID must be numbers" });
      return;
    }

    // Fetch the user and book from the database
    const user = await db.User.findByPk(userId);
    const book = await db.Book.findByPk(bookId);

    // Check if user exists
    if (!user) {
      res.status(404).json({ error: `There is not any user with the ID: ${userId}` });
      return;
    }

    // Check if book exists
    if (!book) {
      res.status(404).json({ error: `There is not any book with the ID: ${bookId}` });
      return;
    }

    // Check if the book is already borrowed by someone
    const existingTransaction = await db.Transaction.findOne({
      where: {
        bookId: bookId,
        returnedAt: null,
      },
    });

    if (existingTransaction) {
      if (existingTransaction.userId === userId) {
        res.status(400).json({ error: "User already has the book." });
        return;
      }
      res.status(400).json({ error: "Book is already borrowed by someone else" });
      return;
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

export const returnBook = async (req: Request, res: Response): Promise<void> => {
  try {
    const userId = parseInt(req.params.userId, 10);
    const bookId = parseInt(req.params.bookId, 10);
    const score = parseInt(req.body.score, 10);

    if (isNaN(userId) || isNaN(bookId) || isNaN(score)) {
      res.status(400).json({ error: "User ID, Book ID, and Score must be numbers" });
      return;
    }

    // Fetch the user and book from the database
    const user = await db.User.findByPk(userId);
    const book = await db.Book.findByPk(bookId);

    // Check if user exists
    if (!user) {
      res.status(404).json({ error: `There is not any user with the ID: ${userId}` });
      return;
    }

    // Check if book exists
    if (!book) {
      res.status(404).json({ error: `There is not any book with the ID: ${bookId}` });
      return;
    }

    // Check if the user has the book
    const existingTransaction = await db.Transaction.findOne({
      where: {
        userId,
        bookId,
        returnedAt: null,
      },
    });

    if (!existingTransaction) {
      res.status(400).json({ error: "User does not have the book" });
      return;
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

// Test route to get transactions
export const getTransactions = async (req: Request, res: Response): Promise<void> => {
  try {
    const transactions: TransactionType[] = await db.Transaction.findAll();
    res.status(200).json(transactions);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "An error occurred while trying to fetch transactions" });
  }
};
