import 'product.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final List<Product> _item = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p5',
      description: 'for food and making juice',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/04/15/08/04/strawberry-1330459_960_720.jpg',
      price: 15,
      title: 'strawberry',
    ),
    Product(
        id: 'p6',
        description: 'for bathing',
        imageUrl:
            'https://cdn.pixabay.com/photo/2017/07/16/22/22/bath-oil-2510783_960_720.jpg',
        price: 100,
        title: 'bath-oil'),
    Product(
        id: 'p7',
        description: 'for moving about and traveling ',
        imageUrl:
            'https://cdn.pixabay.com/photo/2017/08/24/18/25/car-2677839_960_720.jpg',
        price: 5000,
        title: 'car'),
    Product(
        id: 'p8',
        description: 'used for lighting during photo shot by the photographier',
        imageUrl:
            'https://cdn.pixabay.com/photo/2021/07/14/17/23/photography-6466671_960_720.jpg',
        price: 1000,
        title: 'photography light')
  ];

  List<Product> get item {
    return [..._item];
  }

  Product findById(String id) {
    return item.firstWhere((prod) => prod.id == id);
  }

  // List<String> get idGetter {
  //   return item.map((e) => e.id).toList();
  // }
  List<Product> get favoriteItems {
    return _item.where((prod) => prod.isFavourite).toList();
  }

  Future<void> addItem(Product product) {
    // const url = 'https://dushshop-4eb1e-default-rtdb.firebaseio.com/products/';
    var url = Uri.parse(
        'https://dushshop-4eb1e-default-rtdb.firebaseio.com/products.json');
    return http
        .post(url,
            body: jsonEncode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'isFavourite': product.isFavourite,
              'imageUrl': product.imageUrl,
            }))
        .then((response) {
      // ignore: avoid_print
      print(json.decode(response.body));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        title: product.title,
        // isFavourite: false,
      );
      print(newProduct.id);
      _item.add(newProduct);
      notifyListeners();
    });
  }

  void updateItem(String id, Product newProduct) {
    final indexProd = _item.indexWhere((prod) => prod.id == id);
    if (indexProd >= 0) _item[indexProd] = newProduct;
    notifyListeners();
  }

  void deleteItem(String id) {
    _item.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
