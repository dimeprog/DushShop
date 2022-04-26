import '../provider/cart.dart';
import 'package:dushshop/provider/product.dart';
import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem({
  //   required this.id,
  //   required this.imageUrl,
  //   required this.title,
  // });
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    // print('rebuild');
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: ((context, value, child) => IconButton(
                    onPressed: () {
                      product.toggleIsFavorite();
                    },
                    icon: product.isFavourite
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.deepOrange,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.deepOrange,
                          ),
                  )),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              //  Theme.of(context).textTheme.bodyLarge,
              //
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.deepOrange,
              ),
              onPressed: () {
                cart.addItem(product.id, product.title, product.price);
              },
            ),
          ),
        ),
      ),
    );
  }
}
