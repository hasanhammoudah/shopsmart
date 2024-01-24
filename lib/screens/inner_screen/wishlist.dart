import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users/screens/widgets/app_bar_widget.dart';
import 'package:shopsmart_users/screens/widgets/empty_bag.dart';
import 'package:shopsmart_users/screens/widgets/products/product_widget.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});
  static const routeName = "/WishlistScreen";

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? const Scaffold(
            body: EmptyBagWidget(
              imagePath: 'assets/images/bag/bag_wish.png',
              title: 'Nothing in ur wishlist yet!',
              subtitle:
                  'Looks like your cart is empty add something and make me happy',
              buttonText: 'shop now',
            ),
          )
        : Scaffold(
            appBar: AppBarWidget(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
              imagePath: "assets/images/bag/shopping_cart.png",
              child: const TitlesTextWidget(
                label: 'Wishlist (6)',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            body: DynamicHeightGridView(
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              builder: (context, index) {
                return const ProductWidget(productId: '',);
              },
              itemCount: 200,
              crossAxisCount: 2,
            ),
          );
  }
}
