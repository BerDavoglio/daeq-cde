import Seller from '../../models/Application/Seller_models';

class SellerController {
  // Creating User:
  async store(req, res) {
    try {
      await Seller.create(req.body);

      return res.json(req.body);
    } catch (err) {
      return res.status(400)
        .json({ errors: err.errors.map((e) => e.message) });
    }
  }

  // Stock View
  async index(req, res) {
    try {
      const users = await Seller.findAll({
        attributes: ['id', 'product_id', 'qtd', 'employee', 'method_payment', 'created_at'],
      });

      return res.json(users);
    } catch (err) {
      return res.status(400)
        .json({ errors: err.errors.map((e) => e.message) });
    }
  }

  async relat(req, res) {
    try {
      // FAZER RELATÓRIO DE VENDAS!
      return console.log('relat');
    } catch (err) {
      return res.status(400)
        .json({ errors: err.errors.map((e) => e.message) });
    }
  }

  async delete(req, res) {
    try {
      const prod = await Seller.findByPk(req.body.id);
      if (!prod) {
        return res.status(400)
          .json({ errors: ['Product not Found'] });
      }

      await prod.destroy();
      return res.json({ message: 'Product has been Deleted' });
    } catch (err) {
      return res.status(400)
        .json({ errors: err.errors.map((e) => e.message) });
    }
  }
}

export default new SellerController();
