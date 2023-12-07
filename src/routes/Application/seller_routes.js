import { Router } from 'express';
import sellerController from '../../controllers/Application/seller_controller';

const router = new Router();

router.post('/', sellerController.store);
router.get('/', sellerController.index);
router.get('/relat/', sellerController.relat);
router.delete('/', sellerController.delete);

export default router;
