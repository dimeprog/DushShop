import 'package:dushshop/provider/orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem order;
  OrderItemWidget(this.order);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          '\$${order.amount.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat('dd MM yyyy hh:mm').format(order.dateTime),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          icon: Icon(Icons.expand_more),
          onPressed: () {},
        ),
      ),
    );
  }
}
