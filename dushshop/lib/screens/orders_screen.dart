import 'package:dushshop/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import '../provider/orders.dart';
import 'package:provider/provider.dart';
import '../widget/order_item_widget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/order_screen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future<void> refreshOrder(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false).fetchAndSetOrder();
  }

  // var _isLoading = false;

  // @override
  // void initState() {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   Future.delayed(Duration.zero).then((_) async {
  //     await Provider.of<Orders>(context, listen: false).fetchAndSetOrder();
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }
  // using FutureBuilder in  best way
  late Future _orderFuture;

  Future _obtainOrderFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrder();
  }

  @override
  void initState() {
    _orderFuture = _obtainOrderFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context).order;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            }),
        title: const Text('Your Order'),
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshOrder(context),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: 300,
                child: FutureBuilder(
                  // future: Provider.of<Orders>(context, listen: false)
                  //     .fetchAndSetOrder(),
                  future: _orderFuture,
                  builder: (ctx, dataSnapShot) {
                    if (dataSnapShot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (dataSnapShot.error != null) {
                      return const Center(
                        child: Text('An error occur'),
                      );
                    } else {
                      return Consumer<Orders>(
                        builder: (context, orderData, child) =>
                            ListView.builder(
                          itemBuilder: (ctx, i) =>
                              OrderItemWidget(orderData.order[i]),
                          itemCount: orderData.order.length,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
