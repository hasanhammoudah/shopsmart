import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';
import 'package:shopsmart_users/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart_users/screens/inner_screen/wishlist.dart';
import 'package:shopsmart_users/screens/widgets/app_bar_widget.dart';
import 'package:shopsmart_users/screens/widgets/custom_list_title.dart';
import 'package:shopsmart_users/screens/widgets/subtitle_text.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: const AppBarWidget(
        imagePath: "assets/images/bag/shopping_cart.png",
        child: TitlesTextWidget(
          label: 'Profile Screen',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: TitlesTextWidget(
                  label: "Please login to have unlimited access",
                ),
              ),
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Positioned(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).cardColor,
                          border: Border.all(
                            color: Colors.red,
                            width: 3,
                          ),
                        ),
                        child: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitlesTextWidget(
                          label: 'Hasan Hammoudah',
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        SubTitleTextWidget(
                          label: 'Hasan@gmail.com',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TitlesTextWidget(
                    label: "General",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomListTitle(
                    label: 'All Order',
                    onTap: () {},
                    imagePath: 'assets/images/bag/bag_wish.png',
                  ),
                  CustomListTitle(
                    label: 'Wishlist',
                    onTap: () {
                      Navigator.pushNamed(context, WishlistScreen.routeName);
                    },
                    imagePath: 'assets/images/bag/wishlist_svg.png',
                  ),
                  CustomListTitle(
                    label: 'Viewed recently',
                    onTap: () {
                      Navigator.pushNamed(
                          context, ViewedRecentlyScreen.routeName);
                    },
                    imagePath: 'assets/images/profile/recent.png',
                  ),
                  CustomListTitle(
                    label: 'Address',
                    onTap: () {},
                    imagePath: 'assets/images/profile/address.png',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitlesTextWidget(
                    label: "Settings",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SwitchListTile(
                      secondary: Image.asset(
                        'assets/images/profile/theme.png',
                        height: 34,
                      ),
                      title: Text(themeProvider.getIsDarkTheme
                          ? "Dark Mode"
                          : "Light Mode"),
                      value: themeProvider.getIsDarkTheme,
                      onChanged: (value) {
                        themeProvider.setDarkTheme(themeValue: value);
                      }),
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                ),
                onPressed: () async {
                 await MyAppFunctions.showErrorOrWarringDialog(
                      context: context,
                      fct: () {},
                      isError: false,
                      subTitle: 'Are you sure you want to signout');
                },
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                label: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
