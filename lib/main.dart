import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: const Color(0xff647dee),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff7f53ac))
    ),
      home: const Home()
  ));
}
