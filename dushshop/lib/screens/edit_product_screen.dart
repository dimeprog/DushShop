import 'package:dushshop/provider/product_provider.dart';

import '../provider/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit_product_screen';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var isLoading = false;
  var initvalues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var initbool = true;
  var editProduct = Product(
    id: '',
    description: '',
    imageUrl: '',
    price: 0,
    title: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (initbool) {
      final productId = ModalRoute.of(context)?.settings.arguments as String?;
      if (productId != null) {
        editProduct = Provider.of<ProductProvider>(context).findById(productId);
        initvalues = {
          'title': editProduct.title,
          'description': editProduct.description,
          'price': editProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = editProduct.imageUrl;
      }
    }
    initbool = false;
    super.didChangeDependencies();
  }

  // disposing the focusnode to avoid memory leakage
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode;
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      isLoading = true;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Product saved'),
      duration: Duration(seconds: 2),
    ));
    if (editProduct.id != '') {
      Provider.of<ProductProvider>(context, listen: false)
          .updateItem(editProduct.id, editProduct);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .addItem(editProduct)
          .then((_) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit your product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                // autovalidateMode: AutovalidateMode.always,
                key: _form,
                child: ListView(children: [
                  TextFormField(
                    initialValue: initvalues['title'],
                    decoration: InputDecoration(
                      label: Text(
                        'Title',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        // print('validate');
                        return 'please enter the title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      editProduct = Product(
                        id: editProduct.id,
                        description: editProduct.description,
                        imageUrl: editProduct.imageUrl,
                        price: editProduct.price,
                        title: value!,
                        isFavourite: editProduct.isFavourite,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    initialValue: initvalues['price'],
                    decoration: InputDecoration(
                      label: Text(
                        'Price',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter a price.';
                      }
                      if (double.tryParse(value) == null) {
                        return ' please enter a number';
                      }
                      if (double.parse(value) <= 0) {
                        return 'please enter a number above zero';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      editProduct = Product(
                          id: editProduct.id,
                          description: editProduct.description,
                          imageUrl: editProduct.imageUrl,
                          price: double.parse(value!),
                          title: editProduct.title,
                          isFavourite: editProduct.isFavourite);
                    },
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    initialValue: initvalues['description'],
                    decoration: InputDecoration(
                      label: Text(
                        'Description',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    maxLines: 3,
                    focusNode: _descriptionFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter a description';
                      }
                      if (value.length < 10) {
                        return 'please enter  more than 10 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      editProduct = Product(
                          id: editProduct.id,
                          description: value!,
                          imageUrl: editProduct.imageUrl,
                          price: editProduct.price,
                          title: editProduct.title,
                          isFavourite: editProduct.isFavourite);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(
                          top: 8,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.grey,
                          ),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? const Text('No Image loaded')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: TextFormField(
                          // initialValue: initvalues['imageUrl'],
                          controller: _imageUrlController,
                          decoration: InputDecoration(
                            label: Text(
                              'ImageUrl',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          focusNode: _imageUrlFocusNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an image URL.';
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL.';
                            }
                            if (!value.endsWith('.png') &&
                                !value.endsWith('.jpg') &&
                                !value.endsWith('.jpeg')) {
                              return 'Please enter a valid image URL.';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          onSaved: (value) {
                            editProduct = Product(
                              id: editProduct.id,
                              description: editProduct.description,
                              imageUrl: value!,
                              price: editProduct.price,
                              title: editProduct.title,
                              isFavourite: editProduct.isFavourite,
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
    );
  }
}
// https://cdn.pixabay.com/photo/2021/08/31/11/59/androgynous-6588615_960_720.jpg