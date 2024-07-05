import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier{
  final List<Map<String,dynamic>> kart = [];

  void addProduct(Map<String ,dynamic> product) {
    kart.add(product);
    notifyListeners();
  }

  void removeProduct(Map<String ,dynamic> product) {
    kart.remove(product);
    notifyListeners();
  }
}