import Sequelize from 'sequelize';
import databaseConfig from '../config/database';

import Product from '../models/Application/Product_models';
import Seller from '../models/Application/Seller_models';

const models = [Product, Seller];
const connection = new Sequelize(databaseConfig);

connection.authenticate()
  .then(() => {
    console.log("Connection Complete")
  })
  .catch(err => {
    console.log("Connection Erro")
  })

models.forEach((model) => model.init(connection));
