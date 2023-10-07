import { Request, Response } from 'express';
import { validationResult } from 'express-validator';
import db from '../models/index';
import { NewUser, User, UserWithBooks, Transaction, Book } from '../interfaces';

export const createUser = async (req: Request, res: Response): Promise<void> => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    res.status(400).json({ errors: errors.array() });
    return;
  }

  try {
    const user: NewUser = {
      name: req.body.name,
    };
  
    await db.User.create(user);
    res.status(201).send();
  } catch (err) {
    if (err instanceof Error) { // This is a type guard
      // Now TypeScript knows that `err` is an object of type Error within this block
      res.status(500).send({
        message: err.message || "Some error occurred while creating the User.",
      });
    } else {
      // If `err` is not an Error object
      res.status(500).send({
        message: "Some error occurred while creating the User.",
      });
    }
  }
};

export const getUsers = async (req: Request, res: Response): Promise<void> => {
  try {
    const users: User[] = await db.User.findAll({
      attributes: ['id', 'name']
    });
    res.status(200).json(users);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "An error occurred while trying to fetch users" });
  }
};

export const getUser = async (req: Request, res: Response): Promise<void> => {
  try {
    const userId = parseInt(req.params.id, 10);
    if (isNaN(userId)) {
      res.status(400).json({ error: 'User ID must be number' });
      return;
    }

    const user = await db.User.findByPk(userId);

    if (!user) {
      res.status(404).json({ error: "User not found" });
      return;
    }

    const transactions: Transaction[] = await db.Transaction.findAll({
      where: { userId },
      include: db.Book
    });

    const pastBooks = transactions
      .filter(transaction => transaction.returnedAt !== null)
      .map(transaction => {
        return {
          name: (transaction as any).Book.name,
          userScore: transaction.score
        };
      });

    const presentBooks = transactions
      .filter(transaction => transaction.returnedAt === null)
      .map(transaction => {
        return {
          name: (transaction as any).Book.name,
        };
      });

    const responseBody: UserWithBooks = {
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
