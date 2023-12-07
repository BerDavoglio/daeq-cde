// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui.dart';

import '../../../data/data.dart';
import '../../../infra/infra.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final qtdController = TextEditingController();
  final cdbController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });

    Provider.of<StockProvider>(
      context,
      listen: false,
    ).loadStockList(context).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final BuyerProvider buyerProvider = Provider.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[600]!,
                            spreadRadius: 2,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      width: 900,
                      height: 500,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: buyerProvider.cartList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductListItemCleanedModel(
                            context,
                            ItemCondenseDataModel(
                              id: buyerProvider.cartList[index].id,
                              name: buyerProvider.cartList[index].name,
                              cdb: buyerProvider.cartList[index].cdb,
                              value_sell: buyerProvider.cartList[index].value_sell,
                              quantity:
                                  buyerProvider.cartList[index].quantity,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      buttonGeneric(
                        590,
                        90,
                        18,
                        Colors.red,
                        'ADICIONAR PRODUTO',
                        () async => {
                          await showDialog<void>(
                            context: context,
                            builder: (ctx) => Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AlertDialog(
                                    title:
                                        const Text('Quantidade para adicionar'),
                                    content: Column(
                                      children: [
                                        TextFormField(
                                          controller: cdbController,
                                          decoration: const InputDecoration(
                                            labelText: 'CdB',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: qtdController,
                                          decoration: const InputDecoration(
                                            labelText: 'Quantity',
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('Ok'),
                                        onPressed: () async => {
                                          await buyerProvider.addItem(
                                              context, cdbController.text, int.parse(qtdController.text)),
                                          Navigator.of(context).pop(),
                                          qtdController.text = '',
                                          cdbController.text = '',
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        },
                      ),
                      buttonGeneric(
                          290, 90, 20, Colors.grey, 'MÉTODO DE PAGAMENTO', () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.PAYMENT_METHOD);
                      }),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: buttonGeneric(
                        290,
                        90,
                        20,
                        Colors.yellow,
                        'CADASTRAR PRODUTOS',
                        () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.PRODUCT_FORM);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: buttonGeneric(
                        290,
                        90,
                        20,
                        Colors.orange,
                        'ABRIR ESTOQUE',
                        () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.PRODUCT_LIST);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: buttonGeneric(
                        290,
                        90,
                        20,
                        Colors.blue,
                        'NOVA VENDA',
                        () {
                          Provider.of<BuyerProvider>(
                            context,
                            listen: false,
                          ).cleanCart(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[600]!,
                              spreadRadius: 2,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        width: 290,
                        height: 180,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              'Valor Total:',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'R\$${buyerProvider.total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              'MdP: ${buyerProvider.paymentMethod}',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: buttonGeneric(
                        290,
                        90,
                        20,
                        Colors.green,
                        'PAGAR',
                        () {
                          buyerProvider.effectBuy(context);
                          Navigator.of(context).pushNamed(AppRoutes.PAYMENT_VALUE);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
