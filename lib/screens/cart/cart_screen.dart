import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/providers/user_provider.dart';
import 'package:shopsmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users/screens/cart/cart_widget.dart';
import 'package:shopsmart_users/screens/inner_screen/loading_manager.dart';
import 'package:shopsmart_users/screens/search_screen.dart';
import 'package:shopsmart_users/screens/widgets/app_bar_widget.dart';
import 'package:shopsmart_users/screens/widgets/empty_bag.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

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
            bottomSheet: CartBottomSheetWidget(function: () async {
              await placeOrderAdvanced(
                cartProvider: cartProvider,
                productProvider: productProvider,
                userProvider: userProvider,
              );
            }),
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
            body: LoadingManager(
              isLoading: _isLoading,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.getCartitems.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: cartProvider.getCartitems.values
                                .toList()[index],
                            child: const CartWidget());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: kBottomNavigationBarHeight + 10,
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> placeOrderAdvanced({
    required CartProvider cartProvider,
    required ProductProvider productProvider,
    required UserProvider userProvider,
  }) async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      setState(() {
        _isLoading = true;
      });
      cartProvider.getCartitems.forEach((key, value) async {
        final getCurrentProduct = productProvider.findByProdId(value.productId);
        final orderId = const Uuid().v4();
        await FirebaseFirestore.instance
            .collection("ordersAdvanced")
            .doc(orderId)
            .set({
          'orderId': orderId,
          'userId': uid,
          'productId': value.productId,
          "productTitle": getCurrentProduct!.productTitle,
          'price':
              double.parse(getCurrentProduct.productPrice) * value.quantity,
          'totalPrice':
              cartProvider.getTotal(productsProvider: productProvider),
          'quantity': value.quantity,
          'imageUrl': getCurrentProduct.productImage,
          'userName': userProvider.getUserModel!.userName,
          'orderDate': Timestamp.now(),
        });
      });
      await cartProvider.clearCartFromFirebase();
      cartProvider.clearLocalCart();
      MyAppFunctions.showErrorOrWarringDialog(
        context: context,
        fct: () {},
        subTitle: 'Successfully',
      );
    } catch (e) {
      MyAppFunctions.showErrorOrWarringDialog(
        context: context,
        fct: () {},
        subTitle: e.toString(),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
