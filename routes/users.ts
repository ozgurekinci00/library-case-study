import express from 'express';
import { body } from 'express-validator';
import * as usersController from '../controllers/usersController';
import * as transactionsController from '../controllers/transactionsController';

const router = express.Router();

router.post(
  '/',
  [
    body('name')
      .not()
      .isEmpty()
      .withMessage('User name can not be empty!')
      .trim()
      .escape()
  ],
  usersController.createUser
);
router.get('/', usersController.getUsers);
router.get('/:id', usersController.getUser);

// Nested routes for borrowing and returning books
router.post('/:userId/borrow/:bookId', transactionsController.borrowBook);
router.post('/:userId/return/:bookId', transactionsController.returnBook);

// Test route
router.get('/get/transactions', transactionsController.getTransactions);

export default router;
