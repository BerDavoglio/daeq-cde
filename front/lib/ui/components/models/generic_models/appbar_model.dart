import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

PreferredSizeWidget appBarGeneric(
    BuildContext context,
    ) {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Colors.grey[700],
    title: Center(
      child: IconButton(
        icon: Image.asset('lib/ui/assets/image/logo.png'),
        iconSize: 120,
        onPressed: () {
          Navigator.of(context).popAndPushNamed(AppRoutes.HOME);
        },
      )
    ),
  );
}
