import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/models/user_model.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';
import 'package:shopsmart_users/providers/user_provider.dart';
import 'package:shopsmart_users/screens/auth/login_screen.dart';
import 'package:shopsmart_users/screens/inner_screen/loading_manager.dart';
import 'package:shopsmart_users/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart_users/screens/inner_screen/wishlist.dart';
import 'package:shopsmart_users/screens/orders/orders_screen.dart';
import 'package:shopsmart_users/screens/widgets/app_bar_widget.dart';
import 'package:shopsmart_users/screens/widgets/custom_list_title.dart';
import 'package:shopsmart_users/screens/widgets/subtitle_text.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  bool _isLoading = true;

  Future<void> fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      setState(() {
        _isLoading = true;
      });
      userModel = await userProvider.fetchUserInfo();
    } catch (e) {
      await MyAppFunctions.showErrorOrWarringDialog(
        context: context,
        fct: () {},
        subTitle: e.toString(),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: user == null ? true : false,
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: TitlesTextWidget(
                    label: "Please login to have unlimited access",
                  ),
                ),
              ),
              userModel == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  width: 3),
                              image: DecorationImage(
                                image: NetworkImage(
                                  userModel!.userImage,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitlesTextWidget(label: userModel!.userName),
                              const SizedBox(
                                height: 6,
                              ),
                              SubTitleTextWidget(label: userModel!.userEmail)
                            ],
                          )
                        ],
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
                    Visibility(
                      visible: userModel == null ? false : true,
                      child: CustomListTitle(
                        label: 'All Order',
                        onTap: () {
                          Navigator.pushNamed(
                              context, OrdersScreenFree.routeName);
                        },
                        imagePath: 'assets/images/bag/bag_wish.png',
                      ),
                    ),
                    Visibility(
                      visible: userModel == null ? false : true,
                      child: CustomListTitle(
                        label: 'Wishlist',
                        onTap: () {
                          Navigator.pushNamed(
                              context, WishlistScreen.routeName);
                        },
                        imagePath: 'assets/images/bag/wishlist_svg.png',
                      ),
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
                    if (user == null) {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    } else {
                      await MyAppFunctions.showErrorOrWarringDialog(
                          context: context,
                          fct: () async {
                            GoogleSignIn googleSignIn = GoogleSignIn();
                            googleSignIn.disconnect();
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          isError: false,
                          subTitle: 'Are you sure you want to signout');
                    }
                  },
                  icon: Icon(
                    user == null ? Icons.login : Icons.logout,
                    color: Colors.white,
                  ),
                  label: Text(
                    user == null ? 'Login' : 'Logout',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
