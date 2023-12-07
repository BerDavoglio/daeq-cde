import { Router } from 'express';
import productController from '../../controllers/Application/product_controller';

const router = new Router();

router.post('/', productController.store); // Create
router.get('/', productController.index); // Get all
router.put('/', productController.update); // Get all
router.delete('/', productController.delete); // Delete

export default router;
