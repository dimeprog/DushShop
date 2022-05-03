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
    // ignore: non_constant_identifier_names
    final Scaffold = ScaffoldMessenger.of(context);
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
            onPressed: () async {
              try {
                await Provider.of<ProductProvider>(context, listen: false)
                    .deleteItem(id);
              } catch (err) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
                    content: Text(
                      ' Deleting failed',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).errorColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
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
