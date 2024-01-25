import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/screens/widgets/app_bar_widget.dart';
import 'package:shopsmart_users/screens/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/screens/widgets/subtitle_text.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});
  static const routeName = "/ProductDetailsScreen";
  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    // TODO fix issues
    dynamic productId = ModalRoute.of(context)!.settings.arguments;
    final getCurrentProduct =
        productProvider.findByProductId(productId.toString());
    final cartProvider = Provider.of<CartProvider>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const AppBarWidget(
        centerTitle: true,
        child: TitlesTextWidget(
          label: 'Shop smart',
          fontSize: 20,
        ),
      ),
      body: getCurrentProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  FancyShimmerImage(
                    imageUrl: getCurrentProduct.productImage,
                    height: size.height * 0.38,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                getCurrentProduct.productTitle,
                                // TODO What's mean this attribute
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SubTitleTextWidget(
                              label: getCurrentProduct.productPrice,
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HeartButtonWidget(
                                bkgColor: Colors.blue.shade100,
                                productId: getCurrentProduct.productId,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight - 10,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          30,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (cartProvider.isProductCart(
                                          productId:
                                              getCurrentProduct.productId)) {
                                        return;
                                      }
                                      cartProvider.addProductToCart(
                                          productId:
                                              getCurrentProduct.productId);
                                    },
                                    icon: Icon(
                                      color: Colors.white,
                                      cartProvider.isProductCart(
                                              productId:
                                                  getCurrentProduct.productId)
                                          ? Icons.check
                                          : Icons.add_shopping_cart_rounded,
                                    ),
                                    label: Text(
                                      cartProvider.isProductCart(
                                              productId:
                                                  getCurrentProduct.productId)
                                          ? 'in cart'
                                          : 'Add to cart',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitlesTextWidget(
                              label: 'About this item',
                            ),
                            SubTitleTextWidget(
                              label: 'In Phone',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SubTitleTextWidget(
                          label: 'Description' * 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
