import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final double price;
  final String title;
  final String id;
  final int quantity;
  CartItemWidget({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: FittedBox(
              child: Text(
                '\$${price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          '\$${(price * quantity)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        trailing: Text(
          '$quantity x',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            // fontSize: 20,
          ),
        ),
      ),
    );
  }
}
