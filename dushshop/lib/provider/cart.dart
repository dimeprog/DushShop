import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;
  CartItem({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  });
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items = {};
// getters///////////////////////////
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

// functions ////////////////////////////////
  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      // ,,,
      _items.update(
        productId,
        (existItem) => CartItem(
          id: existItem.id,
          price: existItem.price,
          quantity: existItem.quantity + 1,
          title: existItem.title,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          quantity: 1,
          title: title,
        ),
      );
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    if (_items != null) {
      _items.remove(productId);
      notifyListeners();
    }
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    } else if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          price: existingItem.price,
          quantity: existingItem.quantity,
          title: existingItem.title,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
