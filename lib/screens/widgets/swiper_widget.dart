import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users/utils/app_constants.dart';

class SwiperWidget extends StatelessWidget {
  const SwiperWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.25,
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(50),
        child: Swiper(
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              AppConstants.bannersImage[index],
              fit: BoxFit.fill,
            );
          },
          itemCount: AppConstants.bannersImage.length,
          pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              activeColor: Colors.red,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
