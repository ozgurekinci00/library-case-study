import express from 'express';
import { body } from 'express-validator';
import * as booksController from '../controllers/booksController';

const router = express.Router();

router.get('/', booksController.getBooks);
router.post(
  '/',
  [
    body('name')
      .not()
      .isEmpty()
      .withMessage('Book name can not be empty!')
      .trim()
      .escape()
  ],
  booksController.createBook
);
router.get('/:id', booksController.getBook);

export default router;
