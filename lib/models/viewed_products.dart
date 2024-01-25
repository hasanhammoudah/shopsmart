import 'package:flutter/material.dart';

class ViewedProductModel with ChangeNotifier {
  final String viewProdId;
  final String productId;

  ViewedProductModel({
    required this.viewProdId,
    required this.productId,
  });
}
