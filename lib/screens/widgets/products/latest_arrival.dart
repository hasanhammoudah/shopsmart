import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/models/product_model.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/viewed_recently_provider.dart';
import 'package:shopsmart_users/screens/inner_screen/product_details.dart';
import 'package:shopsmart_users/screens/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/screens/widgets/subtitle_text.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewdProdProvider = Provider.of<ViewedProdProvider>(context);

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewdProdProvider.addViewProd(productId: productModel.productId);
          await Navigator.pushNamed(
            context,
            ProductDetailsScreen.routeName,
            arguments: productModel.productId,
          );
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                    imageUrl: productModel.productImage,
                    height: size.width * 0.24,
                    width: size.width * 0.32,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      productModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          HeartButtonWidget(
                            productId: productModel.productId,
                          ),
                          IconButton(
                            onPressed: () async {
                              if (cartProvider.isProdinCart(
                                  productId: productModel.productId)) {
                                return;
                              }
                              try {
                                await cartProvider.addToCartFirebase(
                                  productId: productModel.productId,
                                  qty: 1,
                                  context: context,
                                );
                              } catch (e) {
                                MyAppFunctions.showErrorOrWarringDialog(
                                    context: context,
                                    fct: () {},
                                    subTitle: e.toString());
                              }
                            },
                            icon: Icon(
                              cartProvider.isProdinCart(
                                      productId: productModel.productId)
                                  ? Icons.check
                                  : Icons.add_shopping_cart_rounded,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FittedBox(
                      child: SubTitleTextWidget(
                        label: '${productModel.productPrice}\$',
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
