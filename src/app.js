import express from 'express';
import dotenv from 'dotenv';

import './database';

import productRoutes from './routes/Application/product_routes';
import sellerRoutes from './routes/Application/seller_routes';

dotenv.config();

class App {
  constructor() {
    this.app = express();
    this.middlewares();
    this.routes();
  }

  middlewares() {
    this.app.use(express.urlencoded({ extended: true }));
    this.app.use(express.json());
  }

  routes() {
    this.app.use('/products/', productRoutes);
    this.app.use('/sellers/', sellerRoutes);
  }
}

export default new App().app;
