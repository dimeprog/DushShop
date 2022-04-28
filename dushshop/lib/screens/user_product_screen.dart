import 'package:dushshop/widget/app_drawer.dart';

import '../provider/product.dart';
import '../provider/product_provider.dart';
import '../widget/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user_product_screen';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context).item;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Product'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: 300,
              child: ListView.builder(
                itemBuilder: (ctx, i) => UserProductItem(
                  imageUrl: productData[i].imageUrl,
                  title: productData[i].title,
                ),
                itemCount: productData.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
