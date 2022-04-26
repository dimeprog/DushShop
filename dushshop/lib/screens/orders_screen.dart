import 'package:flutter/material.dart';
import '../provider/orders.dart';
import 'package:provider/provider.dart';
import '../widget/order_item_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order_screen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context).order;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: SizedBox(
            height: 300,
            child: ListView.builder(
              itemBuilder: (ctx, i) => OrderItemWidget(orderData[i]),
              itemCount: orderData.length,
            ),
          ),
        ),
      ),
    );
  }
}
