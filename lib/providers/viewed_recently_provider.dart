import 'package:flutter/material.dart';
import 'package:shopsmart_users/models/viewed_products.dart';
import 'package:uuid/uuid.dart';

class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedProductModel> _viewedProdItems = {};
  Map<String, ViewedProductModel> get getViewedProd {
    return _viewedProdItems;
  }

  void addViewProd({required String productId}) {
    _viewedProdItems.putIfAbsent(
      productId,
      () => ViewedProductModel(
        viewProdId: const Uuid().v4(),
        productId: productId,
      ),
    );
    notifyListeners();
  }
}
