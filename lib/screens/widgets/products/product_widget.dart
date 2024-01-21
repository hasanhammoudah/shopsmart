import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shopsmart_users/screens/widgets/subtitle_text.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';
import 'package:shopsmart_users/utils/app_constants.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FancyShimmerImage(
              imageUrl: AppConstants.imageUrl,
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
                  label: 'Title' * 10,
                  maxLines: 2,
                  fontSize: 18,
                ),
              ),
              Flexible(
                flex: 2,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.heart,
                  ),
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
                const SubTitleTextWidget(
                  label: '1550.00\$',
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
                Material(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.lightBlue,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    splashColor: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(Icons.add_shopping_cart_rounded, size: 20),
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
