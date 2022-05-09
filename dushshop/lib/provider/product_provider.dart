import 'package:dushshop/models/http_exception.dart';

import 'product.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> _item = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
    // Product(
    //   id: 'p5',
    //   description: 'for food and making juice',
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/04/15/08/04/strawberry-1330459_960_720.jpg',
    //   price: 15,
    //   title: 'strawberry',
    // ),
    // Product(
    //     id: 'p6',
    //     description: 'for bathing',
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2017/07/16/22/22/bath-oil-2510783_960_720.jpg',
    //     price: 100,
    //     title: 'bath-oil'),
    // Product(
    //     id: 'p7',
    //     description: 'for moving about and traveling ',
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2017/08/24/18/25/car-2677839_960_720.jpg',
    //     price: 5000,
    //     title: 'car'),
    // Product(
    //     id: 'p8',
    //     description: 'used for lighting during photo shot by the photographier',
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2021/07/14/17/23/photography-6466671_960_720.jpg',
    //     price: 1000,
    //     title: 'photography light')
  ];

  List<Product> get item {
    return [..._item];
  }

  Product findById(String id) {
    return item.firstWhere((prod) => prod.id == id);
  }

  String? token;
  String? userId;
  List? previousProduct;
  void updatedataNotifier(String? _token, String? _userId) {
    token = _token;
    userId = _userId;
    notifyListeners();
  }

//  constructor
  // ProductProvider(
  //   this.token,
  //   this.userId,
  //   this.previousProduct,
  // );

  // method 1

  // List<String> get idGetter {
  //   return item.map((e) => e.id).toList();
  // }
  List<Product> get favoriteItems {
    return _item.where((prod) => prod.isFavourite).toList();
  }

  Future<void> fetchAndSetData([bool filter = false]) async {
    String filterString =
        filter ? 'orderBy="creatorId"&equalTo="${userId}"' : '';
    var url = Uri.parse(
        'https://dushshop-4eb1e-default-rtdb.firebaseio.com/products.json?auth=$token&${filterString}');
    try {
      final response = await http.get(url);
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map?;
      // print(extractedData);
      if (extractedData == null) return;
      final List<Product> loadedProduct = [];
      var urlFavourite = Uri.parse(
          'https://dushshop-4eb1e-default-rtdb.firebaseio.com/Favourite/${userId}.json?auth=$token');
      final favResponse = await http.get(
        urlFavourite,
      );
      final favResponseData = json.decode(favResponse.body);
      print(favResponseData);

      extractedData.forEach((prodId, productData) {
        loadedProduct.add(Product(
          id: prodId,
          description: productData['description'],
          title: productData['title'],
          imageUrl: productData['imageUrl'],
          price: productData['price'],
          isFavourite: favResponseData == null
              ? false
              : favResponseData[prodId] ?? false,
        ));
      });
      _item = loadedProduct;
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }

  Future<void> addItem(Product product) async {
    // const url = 'https://dushshop-4eb1e-default-rtdb.firebaseio.com/products/';
    var url = Uri.parse(
        'https://dushshop-4eb1e-default-rtdb.firebaseio.com/products.json?auth=$token');
    try {
      final response = await http.post(url,
          body: jsonEncode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'creatorId': userId,
          }));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        title: product.title,
        // isFavourite: false,
      );
      // print(newProduct.id);
      _item.add(newProduct);
      notifyListeners();
    } catch (err) {
      // print(err);
      throw err;
    }
  }

  Future<void> updateItem(String id, Product newProduct) async {
    final indexProd = _item.indexWhere((prod) => prod.id == id);
    if (indexProd >= 0) {
      var url = Uri.parse(
          'https://dushshop-4eb1e-default-rtdb.firebaseio.com/products/$id.json?auth=$token');
      await http.patch(url,
          body: jsonEncode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));

      _item[indexProd] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteItem(String id) async {
    final existingIndex = _item.indexWhere((prod) => prod.id == id);
    Product? existProduct = _item[existingIndex];
    _item.removeAt(existingIndex);
    notifyListeners();
    var url = Uri.parse(
        'https://dushshop-4eb1e-default-rtdb.firebaseio.com/products/$id.json?auth=$token');
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _item.insert(existingIndex, existProduct);
      notifyListeners();
      throw HttpException('could not delete product');
    }
    existProduct = null;
  }
}
