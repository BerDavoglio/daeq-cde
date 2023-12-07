import 'package:flutter/material.dart';

Widget inputTextGeneric(
  BuildContext context,
  String text,
  IconData icon,
  bool isPass,
) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: text,
      icon: Icon(
        icon,
        color: Colors.deepOrange[400],
      ),
    ),
    obscureText: isPass,
  );
}

Widget inputTextBoxed(
  BuildContext context,
  String text,
  IconData icon,
  bool isPass,
  TextEditingController controller,
  TextInputType textType,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
    child: TextFormField(
      keyboardType: textType,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColorLight,
            width: 2.0,
          ),
        ),
        labelText: text,
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColorDark,
        ),
        icon: Icon(
          icon,
          color: Colors.deepOrange[400],
        ),
      ),
      obscureText: isPass,
    ),
  );
}
