import { Model, DataTypes, Sequelize } from 'sequelize';

class Transaction extends Model {
  public id!: number;
  public userId!: number;
  public bookId!: number;
  public borrowedAt!: Date;
  public returnedAt!: Date | null; // Note that this is nullable
  public score!: number | null; // This is nullable as well

  // timestamps!
  public readonly createdAt!: Date;
  public readonly updatedAt!: Date;
}

export const initTransaction = (sequelize: Sequelize) => {
  Transaction.init({
    id: {
      type: DataTypes.INTEGER.UNSIGNED,
      autoIncrement: true,
      primaryKey: true,
    },
    userId: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false
    },
    bookId: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false
    },
    borrowedAt: {
      type: new DataTypes.DATE(),
      allowNull: false
    },
    returnedAt: {
      type: new DataTypes.DATE(),
      allowNull: true
    },
    score: {
      type: new DataTypes.FLOAT(),
      allowNull: true
    }
  }, {
    tableName: 'transactions',
    sequelize: sequelize,
  });
  
  return Transaction;
};
