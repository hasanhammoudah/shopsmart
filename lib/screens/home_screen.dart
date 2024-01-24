import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/screens/widgets/app_bar_widget.dart';
import 'package:shopsmart_users/screens/widgets/products/ctg_rounded_widget.dart';
import 'package:shopsmart_users/screens/widgets/products/latest_arrival.dart';
import 'package:shopsmart_users/screens/widgets/swiper_widget.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';
import 'package:shopsmart_users/utils/app_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const AppBarWidget(
        imagePath: "assets/images/bag/shopping_cart.png",
        child: TitlesTextWidget(
          label: 'Shop smart',
          fontSize: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              SwiperWidget(size: size),
              const SizedBox(
                height: 15,
              ),
              const TitlesTextWidget(
                label: 'Latest arrival',
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: size.height * 0.2,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productProvider.getProducts.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: productProvider.getProducts[index],
                        child: const LatestArrivalProductsWidget(),
                      );
                    }),
              ),
              const TitlesTextWidget(
                label: 'Categories',
              ),
              const SizedBox(
                height: 15,
              ),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children:
                    List.generate(AppConstants.categoriesList.length, (index) {
                  return CategoryRoundedWidget(
                      name: AppConstants.categoriesList[index].name,
                      image: AppConstants.categoriesList[index].image);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
