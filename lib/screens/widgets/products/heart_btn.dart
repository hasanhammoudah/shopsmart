import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({
    super.key,
    this.bkgColor = Colors.transparent,
    this.size = 20,
    required this.productId,
  });
  final Color bkgColor;
  final double size;
  final String productId;

  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishlistProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: widget.bkgColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        style: IconButton.styleFrom(
          elevation: 10,
        ),
        onPressed: () async {
          wishListProvider.addOrRemoveFromWishlist(productId: widget.productId);
          if (wishListProvider.getWishlists.containsKey(widget.productId)) {
            wishListProvider.removeWishlistItemFromFirestore(
              wishlistId:
                  wishListProvider.getWishlists[widget.productId]!.wishlistId,
              productId: widget.productId,
            );
          } else {
            wishListProvider.addToWishlistFirebase(
                productId: widget.productId, context: context);
          }
          await wishListProvider.fetchWishlist();
        },
        icon: Icon(
          color: wishListProvider.isProdinWishlist(productId: widget.productId)
              ? Colors.red
              : Colors.grey,
          wishListProvider.isProdinWishlist(productId: widget.productId)
              ? IconlyBold.heart
              : IconlyLight.heart,
          size: widget.size,
        ),
      ),
    );
  }
}
