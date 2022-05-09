import 'dart:convert';
import 'package:dushshop/models/http_exception.dart';
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
  String? token;
  String? userId;

  // token function setter

  void updatedataNotifier(String? _token, String? _userId) {
    token = _token;
    userId = _userId;
    notifyListeners();
  }

//  getters
  List<OrderItem> get order {
    return [..._order];
  }

  // functions
  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    var url = Uri.parse(
        'https://dushshop-4eb1e-default-rtdb.firebaseio.com/orders/${userId}.json?auth=$token');
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: jsonEncode({
            'creatorId': userId,
            'amount': total,
            'dateTime': timeStamp.toIso8601String(),
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'price': cp.price,
                      'quantity': cp.quantity,
                    })
                .toList(),
          }));
      print(json.decode(response.body).toString());
      _order.insert(
        0,
        OrderItem(
          amount: total,
          dateTime: timeStamp,
          products: cartProducts,
          id: json.decode(response.body)['name'],
        ),
      );
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> fetchAndSetOrder([bool filter = false]) async {
    // String filterString =
    //     filter ? 'orderBy="creatorId"&equalTo="${userId}"' : '';
    var url = Uri.parse(
        'https://dushshop-4eb1e-default-rtdb.firebaseio.com/orders/${userId}.json?auth=$token');
    try {
      final response = await http.get(url);
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map;
      final List<OrderItem> loadedOrder = [];
      // ignore: unnecessary_null_comparison
      if (extractedData == null) return;
      extractedData.forEach((orderId, orderData) {
        loadedOrder.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title'],
                  ),
                )
                .toList(),
          ),
        );
      });
      _order = loadedOrder;
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }

  void clear() {
    _order = [];
    notifyListeners();
  }
}
