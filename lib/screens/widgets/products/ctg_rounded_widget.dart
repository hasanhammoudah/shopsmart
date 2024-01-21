import 'package:flutter/material.dart';
import 'package:shopsmart_users/screens/widgets/subtitle_text.dart';

class CategoryRoundedWidget extends StatelessWidget {
  const CategoryRoundedWidget(
      {super.key, required this.image, required this.name});

  final String image, name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          width: 50,
          height: 50,
        ),
        const SizedBox(
          height: 5,
        ),
        SubTitleTextWidget(
          label: name,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
