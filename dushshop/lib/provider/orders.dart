import 'package:dushshop/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final List<CartItem> products;
  final double amount;
  final DateTime dateTime;
  final String id;

  OrderItem({
    required this.amount,
    required this.dateTime,
    required this.products,
    required this.id,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];
//  getters
  List<OrderItem> get order {
    return [..._order];
  }

  // functions
  void addOrder(List<CartItem> orderedProducts, double total) {
    _order.insert(
      0,
      OrderItem(
        amount: total,
        dateTime: DateTime.now(),
        products: orderedProducts,
        id: DateTime.now().toString(),
      ),
    );
    notifyListeners();
  }

  void clear() {
    _order = [];
    notifyListeners();
  }
}
