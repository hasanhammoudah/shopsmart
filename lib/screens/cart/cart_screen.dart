import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users/screens/cart/cart_widget.dart';
import 'package:shopsmart_users/screens/search_screen.dart';
import 'package:shopsmart_users/screens/widgets/app_bar_widget.dart';
import 'package:shopsmart_users/screens/widgets/empty_bag.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartitems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: 'assets/images/bag/shopping_basket.png',
              title: 'Your cart is empty!',
              subtitle:
                  'Looks like your cart is empty add something and make me happy',
              buttonText: 'shop now',
              onPressed: () {
                Navigator.pushNamed(context, SearchScreen.routeName);
              },
            ),
          )
        : Scaffold(
            bottomSheet: const CartBottomSheetWidget(),
            appBar: AppBarWidget(
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppFunctions.showErrorOrWarringDialog(
                        isError: false,
                        context: context,
                        fct: () {
                          cartProvider.clearCartFromFirebase();
                          Navigator.pop(context);
                        },
                        subTitle: 'Clear cart?');
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
              imagePath: "assets/images/bag/shopping_cart.png",
              child: TitlesTextWidget(
                label: 'Cart (${cartProvider.getCartitems.length})',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.getCartitems.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          value:
                              cartProvider.getCartitems.values.toList()[index],
                          child: const CartWidget());
                    },
                  ),
                ),
                const SizedBox(
                  height: kBottomNavigationBarHeight + 10,
                ),
              ],
            ),
          );
  }
}
