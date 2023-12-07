// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:async';
import 'dart:convert';

import 'package:cde/infra/providers/buyer_provider.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui/utils/utils.dart';
import '../../data/data.dart';

class StockProvider with ChangeNotifier {
  final List<ItemCompleteDataModel> _stockList = [];

  List<ItemCompleteDataModel> get stockList => _stockList;

  Future<void> loadStockList(
    BuildContext context,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/products/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      var v = jsonDecode(response.body);

      _stockList.clear();

      v.forEach(
        (value) => _stockList.add(
          ItemCompleteDataModel(
            id: value['id'],
            name: value['name'],
            cdb: value['cdb'],
            value_buy: double.parse(value['value_buy'].toString()),
            value_sell: double.parse(value['value_sell'].toString()),
            quantity_min: value['quantity_min'],
            quantity: value['quantity'],
            // vality: value['vality']
            //     .split('T')[0]
            //     .split('-')
            //     .reversed
            //     .toList()
            //     .join('/'),
            vality: value['vality'],
          ),
        ),
      );

      notifyListeners();
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('StockProvider Error! GetStockList'),
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

  Future<void> addStockItem(
    BuildContext context,
    ItemCompleteDataModel item,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.BACKEND_BASE_URL}/products/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': item.name,
          'cdb': item.cdb,
          'value_buy': item.value_buy,
          'value_sell': item.value_sell,
          'quantity': item.quantity,
          'quantity_min': item.quantity_min,
          'vality': item.vality,
        }),
      );
      var v = jsonDecode(response.body);

      if (v['errors'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Item Added!'),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ));
      } else {
        await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('AddItem Error!'),
            content: Text(v['errors']),
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }

      notifyListeners();
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('StockProvider Error! AddStockList'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => {},
            ),
          ],
        ),
      );
    }
  }

  Future<void> removeStockItem(
    BuildContext context,
    ItemCompleteDataModel item,
  ) async {
    try {
      final response = await http.delete(
        Uri.parse('${Constants.BACKEND_BASE_URL}/products/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'id': item.id,
        }),
      );
      var v = jsonDecode(response.body);

      if (v['errors'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Item Removed!'),
          action: SnackBarAction(
            label: 'Reload!',
            onPressed: () async {
              await loadStockList(context);
            },
          ),
        ));
      } else {
        await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('RemoveItem Error!'),
            content: const Text('Deu erro'),
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }

      notifyListeners();
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('StockProvider Error! RemoveStockList'),
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

  Future findByCDB(
    BuildContext context,
    String cdb,
  ) async {
    try {
      return _stockList.firstWhere((el) => el.cdb == cdb);
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('StockProvider Error! FindByCDB'),
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

  Future<void> popStockItem(
    BuildContext context,
    ItemCondenseDataModel sellItem,
  ) async {
    BuyerProvider buyerProvider = Provider.of(context, listen: false);
    try {
      for (var item in stockList) {
        if (sellItem.cdb == item.cdb) {
          if (sellItem.quantity > item.quantity) {
            throw Exception('Quantidade Insuficiente');
          }

          final response = await http.put(
            Uri.parse('${Constants.BACKEND_BASE_URL}/products/'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'id': item.id,
              'quantity': item.quantity - sellItem.quantity,
            }),
          );
          var v = jsonDecode(response.body);

          if (v['errors'] != null) {
            await showDialog<void>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('AddItem Error!'),
                content: Text(v['errors']),
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

      notifyListeners();
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('StockProvider Error! AddStockList'),
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
