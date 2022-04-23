// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  Product({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.title,
    this.isFavourite = false,
  });

  void toggleIsFavorite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
