import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/data.dart';
import '../../../infra/infra.dart';
import '../../../ui/ui.dart';

class ProductListBody extends StatefulWidget {
  const ProductListBody({super.key});

  @override
  State<ProductListBody> createState() => _ProductListBodyState();
}

class _ProductListBodyState extends State<ProductListBody> {
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
    final StockProvider stockProvider = Provider.of(context);

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              width: 900,
              height: 600,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 7,
                    blurRadius: 21,
                    offset: Offset(10, 10),
                  ),
                ],
              ),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: stockProvider.stockList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductListItemBoxedModel(
                    context,
                    ItemCompleteDataModel(
                      id: stockProvider.stockList[index].id,
                      name: stockProvider.stockList[index].name,
                      cdb: stockProvider.stockList[index].cdb,
                      vality: stockProvider.stockList[index].vality,
                      value_buy: stockProvider.stockList[index].value_buy,
                      value_sell: stockProvider.stockList[index].value_sell,
                      quantity: stockProvider.stockList[index].quantity,
                      quantity_min: stockProvider.stockList[index].quantity_min,
                    ),
                  );
                },
              ),
            ),
          );
  }
}
