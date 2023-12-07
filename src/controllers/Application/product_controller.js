/* eslint-disable camelcase */
import Product from '../../models/Application/Product_models';

class ProductController {
  // Creating:
  async store(req, res) {
    try {
      const newProduct = await Product.create(req.body);

      return res.json(newProduct);
    } catch (err) {
      return res.status(400).json({errors: err.message});
    }
  }

  // Show all:
  async index(req, res) {
    try {
      const products = await Product.findAll();

      return res.json(products);
    } catch (err) {
      return res.status(400).json({errors: err.message});
    }
  }

  // Update the user:
  async update(req, res) {
    try {
      const id = req.body.id;
      if (!id) {
        return res.status(400)
          .json({ errors: ['ID not Found'] });
      }

      const product = await Product.findByPk(id);
      if (!product) {
        return res.status(400)
          .json({ errors: ['Product not Found'] });
      }

      await product.update({
        quantity: req.body.quantity,
      });
      return res.json({ 'message': 'Quantity has been changed!' });
    } catch (err) {
      return res.status(400).json({errors: err.message});
    }
  }

  // Delete:
  async delete(req, res) {
    try {
      const id = req.body.id;
      if (!id) {
        return res.status(400)
          .json({ errors: ['ID not Found'] });
      }

      const product = await Product.findByPk(id);
      if (!product) {
        return res.status(400)
          .json({ errors: ['Product not Found'] });
      }

      await product.destroy();
      return res.json({ 'message': 'Product has been Deleted' });
    } catch (err) {
      return res.status(400).json({errors: err.message});
    }
  }
}

export default new ProductController();
