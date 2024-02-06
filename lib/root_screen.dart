import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/providers/user_provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';
import 'package:shopsmart_users/screens/cart/cart_screen.dart';
import 'package:shopsmart_users/screens/home_screen.dart';
import 'package:shopsmart_users/screens/profile_screen.dart';
import 'package:shopsmart_users/screens/search_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  static const routeName = "/RootScreen";

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  bool isLoadingProd = true;

  @override
  void initState() {
    super.initState();
    screens = const [
      HomeScreen(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    controller = PageController(initialPage: currentScreen);
  }

  Future<void> fetchNCT() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final wishListProvider =
        Provider.of<WishlistProvider>(context, listen: false);

    try {
      Future.wait({productProvider.fetchProduct()});
      Future.wait({wishListProvider.fetchWishlist()});
      Future.wait({cartProvider.fetchCart()});
      Future.wait({userProvider.fetchUserInfo()});
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  void didChangeDependencies() {
    if (isLoadingProd) {
      fetchNCT();
    }
    setState(() {
      // cartProvider
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: currentScreen,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 10,
          height: kBottomNavigationBarHeight,
          destinations: [
            const NavigationDestination(
              icon: Icon(IconlyLight.home),
              label: "Home",
              selectedIcon: Icon(IconlyBold.home),
            ),
            const NavigationDestination(
              icon: Icon(IconlyLight.search),
              label: "Search",
              selectedIcon: Icon(IconlyBold.search),
            ),
            NavigationDestination(
              icon: Badge(
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  label: Text(carProvider.getCartitems.length.toString()),
                  child: const Icon(IconlyLight.bag_2)),
              label: "Cart",
              selectedIcon: const Icon(IconlyBold.bag_2),
            ),
            const NavigationDestination(
              icon: Icon(IconlyLight.profile),
              label: "Profile",
              selectedIcon: Icon(IconlyBold.profile),
            ),
          ],
          onDestinationSelected: (index) {
            setState(() {
              currentScreen = index;
            });
            controller.jumpToPage(currentScreen);
          }),
    );
  }
}
