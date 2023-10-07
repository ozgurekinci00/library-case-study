import { Model, DataTypes, Optional, Sequelize } from 'sequelize';

interface BookAttributes {
  id: number,
  name: string,
}

interface BookCreationAttributes extends Optional<BookAttributes, 'id'> {}

class Book extends Model<BookAttributes, BookCreationAttributes>
  implements BookAttributes {
  id!: number;
  name!: string;
}

export const initBook = (sequelize: Sequelize) => {
  Book.init({
    id: {
      type: DataTypes.INTEGER.UNSIGNED,
      autoIncrement: true,
      primaryKey: true,
    },
    name: {
      type: new DataTypes.STRING(128),
      allowNull: false,
    }
  }, {
    tableName: 'books',
    sequelize: sequelize,
  });
  
  return Book;
}
