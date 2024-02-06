import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/providers/viewed_recently_provider.dart';
import 'package:shopsmart_users/screens/inner_screen/product_details.dart';
import 'package:shopsmart_users/screens/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/screens/widgets/subtitle_text.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct = productProvider.findByProdId(widget.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewdProdProvider = Provider.of<ViewedProdProvider>(context);

    Size size = MediaQuery.of(context).size;
    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : GestureDetector(
            onTap: () async {
              viewdProdProvider.addViewProd(
                  productId: getCurrentProduct.productId);

              await Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                  arguments: getCurrentProduct.productId);
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                    imageUrl: getCurrentProduct.productImage,
                    height: size.height * 0.22,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 5,
                      child: TitlesTextWidget(
                        label: getCurrentProduct.productTitle,
                        maxLines: 2,
                        fontSize: 18,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: HeartButtonWidget(
                        productId: getCurrentProduct.productId,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubTitleTextWidget(
                        label: '${getCurrentProduct.productPrice}\$',
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.lightBlue,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () async {
                            if (cartProvider.isProdinCart(
                                productId: getCurrentProduct.productId)) {
                              return;
                            }
                            try {
                              await cartProvider.addToCartFirebase(
                                productId: getCurrentProduct.productId,
                                qty: 1,
                                context: context,
                              );
                            } catch (e) {
                              MyAppFunctions.showErrorOrWarringDialog(
                                  context: context,
                                  fct: () {},
                                  subTitle: e.toString());
                            }
                            // if (cartProvider.isProductCart(
                            //     productId: getCurrentProduct.productId)) {
                            //   return;
                            // }
                            // cartProvider.addProductToCart(
                            //     productId: getCurrentProduct.productId);
                          },
                          splashColor: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              cartProvider.isProdinCart(
                                      productId: getCurrentProduct.productId)
                                  ? Icons.check
                                  : Icons.add_shopping_cart_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          );
  }
}
