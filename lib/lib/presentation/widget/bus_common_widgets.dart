import 'package:flutter/material.dart';

Widget commonRowWidget(IconData icon, String text, Color colors) {
  return Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Row(
      children: <Widget>[
        Icon(icon, color: colors),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(text),
        ),
      ],
    ),
  );
}