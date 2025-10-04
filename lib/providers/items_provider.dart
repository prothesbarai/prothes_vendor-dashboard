import 'package:flutter/material.dart';
import '../models/item_model.dart';

class ItemsProvider with ChangeNotifier {
  final List<ItemModel> _products = [];

  List<ItemModel> get products => _products;

  void addProduct(ItemModel product) {
    _products.add(product);
    notifyListeners();
  }


  void deleteProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void updateProduct(ItemModel updatedProduct) {
    final index = _products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
      notifyListeners();
    }
  }


}
