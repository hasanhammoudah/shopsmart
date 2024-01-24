import 'package:flutter/material.dart';
import 'package:shopsmart_users/models/product_model.dart';
import 'package:uuid/uuid.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> get getProducts {
    return products;
  }

  ProductModel? findByProductId(String productId) {
    if (products.where((element) => element.productId == productId).isEmpty) {
      return null;
    }
    return products.firstWhere((element) => element.productId == productId);
  }

  List<ProductModel> findByCategory({required String categoryName}) {
    List<ProductModel> categoryList = products
        .where((element) => element.productCategory
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return categoryList;
  }

  List<ProductModel> searchQuery({required String searchText, required List<ProductModel> passedList}) {
    List<ProductModel> searchList = passedList
        .where((element) => element.productTitle
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    return searchList;
  }

  List<ProductModel> products = [
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: 'Apple iphone 14 pro (128) - Black',
      productPrice: '1399.99',
      productCategory: 'Phones',
      productDescription: 'testmndf,msklfcmnkcndskknskndksnfksdmfdzfkzdf',
      productImage:
          'https://media.croma.com/image/upload/v1662655585/Croma%20Assets/Communication/Mobiles/Images/261976_j6acr4.png',
      productQuantity: '10',
    ),
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: 'iphone13-mini,256GB, Midnight - Unlocked()',
      productPrice: '659.99',
      productCategory: 'Phones',
      productDescription: 'testmndf,msklfcmnkcndskknskndksnfksdmfdzfkzdf',
      productImage:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/refurb-iphone-13-mini-midnight-2022?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1679072980362',
      productQuantity: '15',
    ),
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: 'iphone12-mini,256GB, Midnight - Unlocked()',
      productPrice: '400.99',
      productCategory: 'Phones',
      productDescription: 'testmndf,msklfcmnkcndskknskndksnfksdmfdzfkzdf',
      productImage:
          'https://i0.wp.com/3cnz.co.nz/wp-content/uploads/2021/10/Apple-iPhone-13-Mini-512GB-Midnight-1.jpg?fit=760%2C760&ssl=1',
      productQuantity: '9',
    ),
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: 'Laptop',
      productPrice: '800.99',
      productCategory: 'Laptop',
      productDescription:
          'testmndf,msklfcmnkcndskknskndksnfksdmfdzfksdfsdfsaefsaefaesfdzdf',
      productImage:
          'https://cdn.thewirecutter.com/wp-content/media/2023/06/laptops-2048px-5607.jpg?auto=webp&quality=75&crop=1.91:1&width=1200',
      productQuantity: '9',
    ),
  ];
}
