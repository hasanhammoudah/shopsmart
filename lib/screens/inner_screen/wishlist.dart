import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';
import 'package:shopsmart_users/screens/search_screen.dart';
import 'package:shopsmart_users/screens/widgets/app_bar_widget.dart';
import 'package:shopsmart_users/screens/widgets/empty_bag.dart';
import 'package:shopsmart_users/screens/widgets/products/product_widget.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});
  static const routeName = "/WishlistScreen";
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishlistProvider>(context);
    return wishListProvider.getWishlist.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
                imagePath: 'assets/images/bag/bag_wish.png',
                title: 'Nothing in ur wishlist yet!',
                subtitle:
                    'Looks like your cart is empty add something and make me happy',
                buttonText: 'shop now',
                onPressed: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                }),
          )
        : Scaffold(
            appBar: AppBarWidget(
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppFunctions.showErrorOrWarringDialog(
                        isError: false,
                        context: context,
                        fct: () {
                          wishListProvider.clearLocalWishlist();
                        },
                        subTitle: 'Clear wishlist?');
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
              imagePath: "assets/images/bag/shopping_cart.png",
              child: TitlesTextWidget(
                label: 'Wishlist (${wishListProvider.getWishlist.length})',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            body: DynamicHeightGridView(
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              builder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    productId: wishListProvider.getWishlist.values
                        .toList()[index]
                        .productId,
                  ),
                );
              },
              itemCount: wishListProvider.getWishlist.length,
              crossAxisCount: 2,
            ),
          );
  }
}
