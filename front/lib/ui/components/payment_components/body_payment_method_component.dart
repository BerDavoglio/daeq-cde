import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../infra/infra.dart';
import '../../../ui/ui.dart';

class PaymentMethodBody extends StatefulWidget {
  const PaymentMethodBody({super.key});

  @override
  State<PaymentMethodBody> createState() => _PaymentMethodBodyState();
}

class _PaymentMethodBodyState extends State<PaymentMethodBody> {
  @override
  Widget build(BuildContext context) {
    final BuyerProvider buyerProvider = Provider.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconButtonMainScreen(
            context,
            'Dinheiro',
            const Icon(Icons.money),
            () {
              buyerProvider.changePaymentMethod(context, 'Dinheiro');
              Navigator.of(context).pop();
            },
          ),
          iconButtonMainScreen(
            context,
            'Cartão',
            const Icon(Icons.credit_card),
            () {
              buyerProvider.changePaymentMethod(context, 'Cartão');
              Navigator.of(context).pop();
            },
          ),
          iconButtonMainScreen(
            context,
            'PIX',
            const Icon(Icons.pix_outlined),
            () {
              buyerProvider.changePaymentMethod(context, 'PIX');
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
