import 'package:flutter/material.dart';

var grad = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Colors.grey[100], Colors.white]
);

BoxDecoration greyToWhiteDecoration = new BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  gradient: LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Colors.grey[100], Colors.white]
  ),
  border: Border.all(color: Colors.grey[200], width: 1)
);