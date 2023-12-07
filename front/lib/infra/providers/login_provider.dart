import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../../ui/utils/utils.dart';
import '../../data/data.dart';

class LoginProvider with ChangeNotifier {
  String _token = '';

  String get token => _token;

  bool get isAuth {
    return _token != '';
  }

  Future<void> submitLogin(
      BuildContext context, LoginModel item) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.BACKEND_BASE_URL}/jwt/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "email": item.email,
          "password": item.password,
        }),
      );

      var v = jsonDecode(response.body);

      if (v['token'] != '') {
        _token = v['token'];
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
      } else if (v['errors'] != '') {
        // Login Inválido
        await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Login Error!'),
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
          title: const Text('LoginProvider Error! Login'),
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

  Future<void> logout() async {
    _token = '';

    notifyListeners();
  }
}
