import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/viewed_recently_provider.dart';
import 'package:shopsmart_users/screens/widgets/app_bar_widget.dart';
import 'package:shopsmart_users/screens/widgets/empty_bag.dart';
import 'package:shopsmart_users/screens/widgets/products/product_widget.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  const ViewedRecentlyScreen({super.key});
  static const routeName = "/ViewedRecentlyScreen";

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final viewdProdProvider = Provider.of<ViewedProdProvider>(context);
    return viewdProdProvider.getViewedProd.isEmpty
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
                  onPressed: () {
                    // MyAppFunctions.showErrorOrWarringDialog(
                    //     isError: false,
                    //     context: context,
                    //     fct: () {
                    //      viewdProdProvider.
                    //     },
                    //     subTitle: 'Clear viewed?');
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
              imagePath: "assets/images/bag/shopping_cart.png",
              child: TitlesTextWidget(
                label:
                    'Viewed recently (${viewdProdProvider.getViewedProd.length})',
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
                    productId: viewdProdProvider.getViewedProd.values
                        .toList()[index]
                        .productId,
                  ),
                );
              },
              itemCount: viewdProdProvider.getViewedProd.length,
              crossAxisCount: 2,
            ),
          );
  }
}
