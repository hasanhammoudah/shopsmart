import 'package:flutter/material.dart';
import 'package:shopsmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users/screens/cart/cart_widget.dart';
import 'package:shopsmart_users/screens/widgets/app_bar_widget.dart';
import 'package:shopsmart_users/screens/widgets/empty_bag.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? const Scaffold(
            body: EmptyBagWidget(
              imagePath: 'assets/images/bag/shopping_basket.png',
              title: 'Your cart is empty!',
              subtitle:
                  'Looks like your cart is empty add something and make me happy',
              buttonText: 'shop now',
            ),
          )
        : Scaffold(
            bottomSheet: const CartBottomSheetWidget(),
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
                label: 'Cart (6)',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            body: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const CartWidget();
              },
            ),
          );
  }
}
