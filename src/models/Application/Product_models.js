import Sequelize, {Model} from 'sequelize';

export default class Product extends Model {
  static init(sequelize) {
    super.init({
      name: {
        type: Sequelize.STRING,
        defaultValue: '',
        validate: {
          len: {
            args: [3, 100],
            msg: 'NAME is invalid',
          },
        },
      },
      cdb: {
        type: Sequelize.STRING,
        defaultValue: 0,
      },
      value_buy: {
        type: Sequelize.DOUBLE,
        defaultValue: 0,
      },
      value_sell: {
        type: Sequelize.DOUBLE,
        defaultValue: 0,
      },
      quantity: {
        type: Sequelize.INTEGER,
        defaultValue: 0,
      },
      quantity_min: {
        type: Sequelize.INTEGER,
        defaultValue: 0,
      },
      vality: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.NOW,
      },
    }, {
      sequelize,
    });

    return this;
  }
}
