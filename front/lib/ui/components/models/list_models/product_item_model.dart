import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/data.dart';
import '../../../../infra/infra.dart';
import '../../../ui.dart';

Widget ProductListItemBoxedModel(
  BuildContext context,
  ItemCompleteDataModel data,
) {
  final StockProvider stockProvider = Provider.of(context);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      height: 150,
      width: 800,
      decoration: BoxDecoration(
        color: Colors.grey[300]!,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[600]!,
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: data.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' (CDB: ${data.cdb})')
                    ],
                  ),
                ),
                Text(
                  'Valor Pago: R\$${data.value_buy.toStringAsFixed(2)}; Valor Anunciado: R\$${data.value_sell.toStringAsFixed(2)}; Quantidade: ${data.quantity}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                buttonGeneric(120, 40, 5, Colors.red, 'Remove', () {
                  stockProvider.removeStockItem(context, data);
                }),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget ProductListItemCleanedModel(
  BuildContext context,
  ItemCondenseDataModel data,
) {
  final BuyerProvider buyerProvider = Provider.of(context);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      children: [
        SizedBox(
          height: 80,
          width: 800,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: data.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: ' (CDB: ${data.cdb})')
                        ],
                      ),
                    ),
                    Text(
                      'ID: ${data.id} | Valor Unitário: R\$${data.value_sell.toStringAsFixed(2)} | Quantidade: ${data.quantity}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    buttonGeneric(120, 40, 5, Colors.red, 'Remove', () {
                      buyerProvider.removeItem(context, data);
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Divider(
            thickness: 2,
            color: Colors.grey[500]!,
          ),
        ),
      ],
    ),
  );
}
