const { Model, DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  class User extends Model {}
  User.init({
    name: {
      type: DataTypes.STRING,
      allowNull: false
    }
  }, { sequelize, modelName: 'User' });

  User.associate = (models) => {
    User.hasMany(models.Transaction, {
      foreignKey: 'userId',
    });
  };

  return User;
};
