const express = require("express");
const router = express.Router();
const { body } = require("express-validator");
const usersController = require("../controllers/usersController");
const transactionsController = require("../controllers/transactionsController");

router.post(
  "/",
  [
    body("name")
      .not()
      .isEmpty()
      .withMessage("User name can not be empty!")
      .trim()
      .escape(),
  ],
  usersController.createUser
);
router.get("/", usersController.getUsers);
router.get("/:id", usersController.getUser);

// Nested routes for borrowing and returning books
router.post("/:userId/borrow/:bookId", transactionsController.borrowBook);
router.post("/:userId/return/:bookId", transactionsController.returnBook);

// Test route
router.get("/get/transactions", transactionsController.getTransactions);

module.exports = router;
