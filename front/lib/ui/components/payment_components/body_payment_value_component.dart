import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../infra/infra.dart';

class PaymentValueBody extends StatefulWidget {
  const PaymentValueBody({super.key});

  @override
  State<PaymentValueBody> createState() => _PaymentValueBodyState();
}

class _PaymentValueBodyState extends State<PaymentValueBody> {
  @override
  Widget build(BuildContext context) {
    final BuyerProvider buyerProvider = Provider.of(context);

    return Center(
      child: Container(
        width: 500,
        height: 450,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[800]!,
              spreadRadius: 7,
              blurRadius: 21,
              offset: const Offset(10, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Valor Total: R\$${buyerProvider.total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Método de Pagamento: ${buyerProvider.paymentMethod}',
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            buyerProvider.paymentMethod == 'PIX'
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 42),
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 7,
                            blurRadius: 21,
                            offset: Offset(-10, 10),
                          ),
                        ],
                      ),
                      child: Image.network(
                        'https://play-lh.googleusercontent.com/ufwUy4SGVTqCs8fcp6Ajxfpae0bNImN1Rq2cXUjWI7jlmNMCsXgQE5C3yUEzBu5Gadkz',
                        scale: 3,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
