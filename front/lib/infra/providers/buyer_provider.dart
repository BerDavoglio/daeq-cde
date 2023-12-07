import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../infra.dart';

class BuyerProvider with ChangeNotifier {
  List get cartList => _cartList;
  List<ItemCondenseDataModel> _cartList = [];

  double get total => _total;
  double _total = 0;

  String get paymentMethod => _paymentMethod;
  String _paymentMethod = '-=-';

  Future<void> addItem(BuildContext context, String cdb, int qtd) async {
    final StockProvider stockProvider = Provider.of(context, listen: false);

    try {
      for (var item in stockProvider.stockList) {
        if (item.cdb == cdb) {
          _cartList.add(ItemCondenseDataModel(
              id: item.id,
              name: item.name,
              cdb: cdb,
              value_sell: item.value_sell,
              quantity: qtd));
          loadTotalValue(context, true);
        }
      }

      notifyListeners();
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('BuyerProvider Error! AddItem'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future<void> removeItem(
      BuildContext context, ItemCondenseDataModel item) async {
    try {
      loadTotalValue(context, false);
      _cartList.removeAt(_cartList.indexWhere((el) => el.id == item.id));

      notifyListeners();
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('BuyerProvider Error! RemoveItem'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future<void> loadTotalValue(BuildContext context, bool remove) async {
    try {
      if (!remove) {
        _cartList
            .forEach((value) => _total -= (value.value_sell * value.quantity));
      } else {
        _cartList
            .forEach((value) => _total += (value.value_sell * value.quantity));
      }

      notifyListeners();
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('BuyerProvider Error! LoadTotalValue'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future<void> cleanCart(BuildContext context) async {
    try {
      _cartList.clear();
      _total = 0;

      notifyListeners();
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('BuyerProvider Error! LoadTotalValue'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future<void> changePaymentMethod(BuildContext context, String method) async {
    try {
      _paymentMethod = method;

      notifyListeners();
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('BuyerProvider Error! ChangePaymentMethod'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future<void> effectBuy(BuildContext context) async {
    try {
      final StockProvider stockProvider = Provider.of(context, listen: false);
      _cartList.forEach((item) {
        stockProvider.popStockItem(context, item);
      });

      // Gerar relatório de vendas

      notifyListeners();
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('BuyerProvider Error! EffectBuy'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}
