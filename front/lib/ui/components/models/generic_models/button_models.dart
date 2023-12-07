import 'package:flutter/material.dart';

Widget iconButtonMainScreen(
  BuildContext context,
  String text,
  Icon icon,
  Function func,
) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: SizedBox(
      width: 400,
      height: 80,
      child: ElevatedButton.icon(
        icon: icon,
        label: Text(
          text,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColorDark),
        ),
        onPressed: () {
          func();
        },
      ),
    ),
  );
}

Widget buttonMainScreen(
  BuildContext context,
  String text,
  Function func,
) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: SizedBox(
      width: 400,
      height: 80,
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColorDark),
        ),
        onPressed: () {
          func();
        },
      ),
    ),
  );
}

Widget buttomSelectGeneral(
  BuildContext context,
  String text,
  Color color,
  Function func,
) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: SizedBox(
      width: 200,
      height: 70,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed: () {
          func();
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    ),
  );
}

Widget buttonGeneric(
  double widthButton,
  double heightButton,
  double radiusBorderButton,
  Color colorButton,
  String title,
  Function func,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: SizedBox(
      width: widthButton,
      height: heightButton,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(5),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusBorderButton),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(colorButton),
        ),
        onPressed: () {
          func();
        },
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
      ),
    ),
  );
}
