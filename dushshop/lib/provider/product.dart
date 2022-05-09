// ignore_for_file: prefer_function_declarations_over_variables

// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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
  void _updatefav(newval) {
    isFavourite = newval;
    notifyListeners();
  }

  Future<void> toggleIsFavorite(String? token, String? userId) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    var url = Uri.parse(
        'https://dushshop-4eb1e-default-rtdb.firebaseio.com/Favourite/${userId}/$id.json?auth=$token');

    try {
      final response = await http.put(url,
          body: jsonEncode(
            isFavourite,
          ));
      if (response.statusCode >= 400) {
        // isFavourite = oldStatus;
        // notifyListeners();
        _updatefav(oldStatus);
      }
    } catch (err) {
      // isFavourite = oldStatus;
      // notifyListeners();
      _updatefav(oldStatus);
    }
  }
}
