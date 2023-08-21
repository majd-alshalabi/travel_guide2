import 'package:flutter/material.dart';

class AppConstant {
  static const String appName = 'Bint Al Kol';
}
class Constant {
  static LinearGradient primaryBodyColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFBDC3C7), Color(0xFF2c3e50)],
  );


  static List<String> type = [
    "restaurant",
    "hotel",
    "must see",
    "Places of entertainment"
  ];
}