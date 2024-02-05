import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/order_provider.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';
import 'package:shopsmart_users/providers/user_provider.dart';
import 'package:shopsmart_users/providers/viewed_recently_provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:shopsmart_users/screens/auth/forgot_password.dart';
import 'package:shopsmart_users/screens/auth/login_screen.dart';
import 'package:shopsmart_users/screens/auth/register_screen.dart';
import 'package:shopsmart_users/screens/inner_screen/product_details.dart';
import 'package:shopsmart_users/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart_users/screens/inner_screen/wishlist.dart';
import 'package:shopsmart_users/screens/orders/orders_screen.dart';
import 'package:shopsmart_users/screens/search_screen.dart';
import 'package:shopsmart_users/utils/firebase_key.dart';
import 'package:shopsmart_users/utils/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseKey = FirebaseKey();
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(
          options: FirebaseOptions(
            storageBucket: firebaseKey.storageBucket,
            apiKey: firebaseKey.apiKey,
            appId: firebaseKey.appId,
            messagingSenderId: firebaseKey.messagingSenderId,
            projectId: firebaseKey.projectId,
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: SelectableText(snapshot.error.toString()),
                ),
              ),
            );
          }
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
              ChangeNotifierProvider(create: (_) {
                return WishlistProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ViewedProdProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return UserProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return OrderProvider();
              }),
            ],
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'ShopSmart',
                  theme: Styles.themeData(
                      isDarkTheme: themeProvider.getIsDarkTheme,
                      context: context),
                  home: const RootScreen(),
                  routes: {
                    SearchScreen.routeName: (context) => const SearchScreen(),
                    OrdersScreenFree.routeName: (context) =>
                        const OrdersScreenFree(),
                    LoginScreen.routeName: (context) => const LoginScreen(),
                    ForgotPasswordScreen.routeName: (context) =>
                        const ForgotPasswordScreen(),
                    RootScreen.routeName: (context) => const RootScreen(),
                    ProductDetailsScreen.routeName: (context) =>
                        const ProductDetailsScreen(),
                    WishlistScreen.routeName: (context) =>
                        const WishlistScreen(),
                    ViewedRecentlyScreen.routeName: (context) =>
                        const ViewedRecentlyScreen(),
                    RegisterScreen.routeName: (context) =>
                        const RegisterScreen(),
                  },
                );
              },
            ),
          );
        });
  }
}
