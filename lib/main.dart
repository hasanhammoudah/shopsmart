import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:shopsmart_users/screens/auth/forgot_password.dart';
import 'package:shopsmart_users/screens/auth/login_screen.dart';
import 'package:shopsmart_users/screens/auth/register_screen.dart';
import 'package:shopsmart_users/screens/inner_screen/product_details.dart';
import 'package:shopsmart_users/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart_users/screens/inner_screen/wishlist.dart';
import 'package:shopsmart_users/screens/search_screen.dart';
import 'package:shopsmart_users/utils/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return ThemeProvider();
        }),
         ChangeNotifierProvider(create: (_) {
          return ProductProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          return CartProvider();
        }),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ShopSmart',
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: const RootScreen(),
          routes: {
            SearchScreen.routeName: (context) => const SearchScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            ForgotPasswordScreen.routeName: (context) =>
                const ForgotPasswordScreen(),
            RootScreen.routeName: (context) => const RootScreen(),
            ProductDetailsScreen.routeName: (context) =>
                const ProductDetailsScreen(productId: '',),
            WishlistScreen.routeName: (context) => const WishlistScreen(),
            ViewedRecentlyScreen.routeName: (context) =>
                const ViewedRecentlyScreen(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
          },
        );
      }),
    );
  }
}
