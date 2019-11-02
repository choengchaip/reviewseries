import 'package:flutter/material.dart';
import 'Pages/HomePage.dart';

void main() {
  runApp(MaterialApp(
    title: 'Review Series',
    home: home_page(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'faiIce'
    ),
  ));
}