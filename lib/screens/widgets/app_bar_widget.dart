import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.child,
    this.imagePath,
    this.actions, this.centerTitle,
  });
  final Widget child;
  final String? imagePath;
  final List<Widget>? actions;
  final bool? centerTitle;
  @override
  Widget build(BuildContext context) {
    return AppBar(
     // TODO this line not show the leading icon
      //  automaticallyImplyLeading: false,
      actions: actions,
      centerTitle: centerTitle,
      title: child,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: imagePath != null
            ? Image.asset(imagePath ?? '')
            : IconButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
              ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
