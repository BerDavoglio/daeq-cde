import Sequelize, { Model } from 'sequelize';

export default class Seller extends Model {
  static init(sequelize) {
    super.init({
      product_id: {
        type: Sequelize.INTEGER,
        defaultValue: 0,
      },
      qtd: {
        type: Sequelize.INTEGER,
        defaultValue: 0,
      },
      employee: {
        type: Sequelize.STRING,
        defaultValue: '',
      },
      method_payment: {
        type: Sequelize.STRING,
        defaultValue: '',
      },
    }, {
      sequelize,
    });

    return this;
  }
}
