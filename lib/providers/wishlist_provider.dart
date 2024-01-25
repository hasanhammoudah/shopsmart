import 'package:flutter/material.dart';
import 'package:shopsmart_users/models/wishlist_model.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};
  Map<String, WishlistModel> get getWishlist {
    return _wishlistItems;
  }

  void addOrRemoveFromWishlist({required String productId}) {
    if (_wishlistItems.containsKey(productId)) {
      _wishlistItems.remove(productId);
    } else {
      // TODO whats mean putIfAbsent
      _wishlistItems.putIfAbsent(
        productId,
        () => WishlistModel(
          wishlistId: const Uuid().v4(),
          productId: productId,
        ),
      );
    }

    notifyListeners();
  }

  bool isProductWishlist({required String productId}) {
    return _wishlistItems.containsKey(productId);
  }

  void clearLocalWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
