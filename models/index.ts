import { Sequelize } from 'sequelize';
import { initBook } from './Book';
import { initUser } from './User';
import { initTransaction } from './Transaction';

const env = process.env.NODE_ENV || "development";
const config = require(__dirname + "/../config/config.json")[env];

let sequelize;
if (config.use_env_variable) {
  sequelize = new Sequelize(process.env[config.use_env_variable] as string, config);
} else {
  sequelize = new Sequelize(
    config.database,
    config.username,
    config.password,
    config
  );
}

const User = initUser(sequelize);
const Book = initBook(sequelize);
const Transaction = initTransaction(sequelize);

// Associations
Book.hasMany(Transaction, { foreignKey: 'bookId' });
User.hasMany(Transaction, { foreignKey: 'userId' });
Transaction.belongsTo(Book, { foreignKey: 'bookId' });
Transaction.belongsTo(User, { foreignKey: 'userId' });

const db = {
  sequelize: sequelize,
  Sequelize: Sequelize,
  User: User,
  Book: Book,
  Transaction: Transaction
};

export default db;
