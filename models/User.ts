import { Model, DataTypes, Optional, Sequelize } from 'sequelize';

interface UserAttributes {
  id: number;
  name: string;
}

interface UserCreationAttributes extends Optional<UserAttributes, 'id'> {}

class User extends Model<UserAttributes, UserCreationAttributes>
  implements UserAttributes {
  id!: number;
  name!: string;
}

export const initUser = (sequelize: Sequelize) => {
  User.init({
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
    tableName: 'users',
    sequelize: sequelize,
  });
  
  return User;
};
