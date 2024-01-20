import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.child,
    required this.imagePath, this.actions,
  });
  final Widget child;
  final String imagePath;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      title: child,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(imagePath),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
