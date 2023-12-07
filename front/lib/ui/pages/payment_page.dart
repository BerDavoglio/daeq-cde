import 'package:flutter/material.dart';

import '../ui.dart';

class PaymentValuePage extends StatefulWidget {
  const PaymentValuePage({Key? key}) : super(key: key);

  @override
  State<PaymentValuePage> createState() => _PaymentValuePageState();
}

class _PaymentValuePageState extends State<PaymentValuePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarGeneric(context),
      body: const PaymentValueBody()
    );
  }
}
