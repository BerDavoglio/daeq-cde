import 'package:cde/infra/infra.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../data/data.dart';
import '../../../ui/ui.dart';

class ProductFormBody extends StatefulWidget {
  const ProductFormBody({super.key});

  @override
  State<ProductFormBody> createState() => _ProductFormBodyState();
}

class _ProductFormBodyState extends State<ProductFormBody> {
  final nameController = TextEditingController();
  final cdbController = TextEditingController();
  final buyController = TextEditingController();
  final sellController = TextEditingController();
  final qtdController = TextEditingController();
  final qtdMinController = TextEditingController();
  final valityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final StockProvider stockProvider = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'ADICIONAR PRODUTO',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 70),
                          child: Form(
                            child: Column(
                              children: [
                                inputTextBoxed(
                                    context,
                                    'Nome',
                                    Icons.emoji_objects_outlined,
                                    false,
                                    nameController,
                                    TextInputType.text),
                                inputTextBoxed(
                                    context,
                                    'Código de Barra',
                                    Icons.broken_image_outlined,
                                    false,
                                    cdbController,
                                    TextInputType.number),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: inputTextBoxed(
                                        context,
                                        'Valor Pago',
                                        Icons.payment_outlined,
                                        false,
                                        buyController,
                                        TextInputType.number,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: inputTextBoxed(
                                        context,
                                        'Valor Vendido',
                                        Icons.payments_outlined,
                                        false,
                                        sellController,
                                        TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                inputTextBoxed(
                                    context,
                                    'Quantidade',
                                    Icons.add_box_outlined,
                                    false,
                                    qtdController,
                                    TextInputType.number),
                                inputTextBoxed(
                                  context,
                                  'Quantidade Mínima',
                                  Icons.indeterminate_check_box_outlined,
                                  false,
                                  qtdMinController,
                                  TextInputType.number,
                                ),
                                inputTextBoxed(
                                  context,
                                  'Validade',
                                  Icons.indeterminate_check_box_outlined,
                                  false,
                                  valityController,
                                  TextInputType.text,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            buttomSelectGeneral(
                              context,
                              'Salvar',
                              Colors.green,
                              () async => {
                                if (DateTime.tryParse(DateFormat("dd/MM/yyyy")
                                        .parse(valityController.text)
                                        .toString()) !=
                                    null)
                                  {
                                    await stockProvider.addStockItem(
                                      context,
                                      ItemCompleteDataModel(
                                        name: nameController.text,
                                        cdb: cdbController.text,
                                        value_buy: double.parse(buyController
                                            .text
                                            .replaceAll(',', '.')),
                                        value_sell: double.parse(sellController
                                            .text
                                            .replaceAll(',', '.')),
                                        quantity: int.parse(qtdController.text),
                                        quantity_min:
                                            int.parse(qtdMinController.text),
                                        vality: DateFormat("dd/MM/yyyy")
                                            .parse(valityController.text)
                                            .toString(),
                                      ),
                                    ),
                                  },
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
