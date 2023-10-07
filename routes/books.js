const express = require("express");
const router = express.Router();
const { body } = require("express-validator");
const booksController = require("../controllers/booksController");

router.get("/", booksController.getBooks);
router.post(
  "/",
  [
    body("name")
      .not()
      .isEmpty()
      .withMessage("Book name can not be empty!")
      .trim()
      .escape(),
  ],
  booksController.createBook
);
router.get("/:id", booksController.getBook);

module.exports = router;
