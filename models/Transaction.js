const { Model, DataTypes } = require("sequelize");

module.exports = (sequelize) => {
  class Transaction extends Model {}
  Transaction.init(
    {
      userId: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "Users",
          key: "id",
        },
      },
      bookId: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "Books",
          key: "id",
        },
      },
      borrowedAt: {
        type: DataTypes.DATE,
        allowNull: false,
      },
      returnedAt: {
        type: DataTypes.DATE,
        allowNull: true,
      },
      score: {
        type: DataTypes.FLOAT,
        allowNull: true,
      },
    },
    { sequelize, modelName: "Transaction" }
  );

  Transaction.associate = (models) => {
    Transaction.belongsTo(models.User, {
      foreignKey: "userId",
    });
    Transaction.belongsTo(models.Book, {
      foreignKey: "bookId",
    });
  };

  return Transaction;
};
