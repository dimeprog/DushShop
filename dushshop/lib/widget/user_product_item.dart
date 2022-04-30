import 'package:dushshop/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  UserProductItem({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: id);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.lightBlueAccent,
            ),
          ),
          IconButton(
            onPressed: () {
              Provider.of<ProductProvider>(context, listen: false)
                  .deleteItem(id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.pinkAccent,
            ),
          ),
        ]),
      ),
    );
  }
}
