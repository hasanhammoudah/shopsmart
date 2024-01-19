import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shopsmart_users/screens/widgets/subtitle_text.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({super.key, this.onTap, this.label, this.imagePath});

  final void Function()? onTap;
  final String? label, imagePath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: SubTitleTextWidget(
        label: label,
      ),
      leading: Image.asset(
        imagePath!,
        height: 30,
      ),
      trailing: const Icon(IconlyLight.arrow_right_2),
    );
  }
}
