import 'package:dushshop/screens/edit_product_screen.dart';
import 'package:dushshop/widget/app_drawer.dart';

import '../provider/product.dart';
import '../provider/product_provider.dart';
import '../widget/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user_product_screen';
  Future<void> refreshData(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchAndSetData(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<ProductProvider>(context).item;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Product'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: refreshData(context),
        builder: (context, dataSnapshot) =>
            dataSnapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => refreshData(context),
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 300,
                            child: Consumer<ProductProvider>(
                              builder: (context, productData, _) =>
                                  ListView.builder(
                                itemBuilder: (ctx, i) => UserProductItem(
                                  id: productData.item[i].id,
                                  imageUrl: productData.item[i].imageUrl,
                                  title: productData.item[i].title,
                                ),
                                itemCount: productData.item.length,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
