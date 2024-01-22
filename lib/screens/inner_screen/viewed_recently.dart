import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users/screens/widgets/app_bar_widget.dart';
import 'package:shopsmart_users/screens/widgets/empty_bag.dart';
import 'package:shopsmart_users/screens/widgets/products/product_widget.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  const ViewedRecentlyScreen({super.key});
  static const routeName = "/ViewedRecentlyScreen";

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? const Scaffold(
            body: EmptyBagWidget(
              imagePath: 'assets/images/bag/order.png',
              title: 'No viewed products yet',
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
                label: 'Viewed recently (6)',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            body: DynamicHeightGridView(
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              builder: (context, index) {
                return const ProductWidget();
              },
              itemCount: 200,
              crossAxisCount: 2,
            ),
          );
  }
}
