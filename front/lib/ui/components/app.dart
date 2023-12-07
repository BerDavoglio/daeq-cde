import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui.dart';

import '../../infra/infra.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BuyerProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StockProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DAEQ + DAEP - Controle de Estoque',
        theme: ThemeData(
          primaryColorDark: Colors.grey[800]!,
          primaryColorLight: Colors.grey[400]!,
          primaryColor: Colors.grey,
          scaffoldBackgroundColor: const Color.fromRGBO(255, 217, 172, 1),
        ),
        routes: {
          AppRoutes.HOME: (_) => const HomePage(),
          AppRoutes.LOGIN: (_) => const LoginPage(),
          AppRoutes.PAYMENT_VALUE: (_) => const PaymentValuePage(),
          AppRoutes.PAYMENT_METHOD: (_) => const PaymentMethodPage(),
          AppRoutes.PRODUCT_FORM: (_) => const ProductFormPage(),
          AppRoutes.PRODUCT_LIST: (_) => const ProductListPage(),
        },
      ),
    );
  }
}
