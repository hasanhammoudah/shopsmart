import 'package:shopsmart_users/models/categories_model.dart';

class AppConstants {
  static const String imageUrl =
      'https://cdn.britannica.com/77/170477-050-1C747EE3/Laptop-computer.jpg';

  static List<String> bannersImage = [
    'assets/images/banners/banner1.png',
    'assets/images/banners/banner2.png'
  ];

  static List<CategoriesModel> categoriesList = [
    const CategoriesModel(
        id: "assets/images/categories/mobiles.png",
        name: "Phones",
        image: "assets/images/categories/mobiles.png"),
    const CategoriesModel(
        id: "assets/images/categories/pc.png",
        name: "Laptops",
        image: "assets/images/categories/pc.png"),
    const CategoriesModel(
        id: "assets/images/categories/electronics.png",
        name: "Electronics",
        image: "assets/images/categories/electronics.png"),
    const CategoriesModel(
        id: "assets/images/categories/watch.png",
        name: "Watches",
        image: "assets/images/categories/watch.png"),
    const CategoriesModel(
        id: "assets/images/categories/fashion.png",
        name: "Clothes",
        image: "assets/images/categories/fashion.png"),
    const CategoriesModel(
        id: "assets/images/categories/shoes.png",
        name: "Shoes",
        image: "assets/images/categories/shoes.png"),
    const CategoriesModel(
        id: "assets/images/categories/book_img.png",
        name: "Books",
        image: "assets/images/categories/book_img.png"),
    const CategoriesModel(
        id: "assets/images/categories/cosmetics.png",
        name: "Cosmetics",
        image: "assets/images/categories/cosmetics.png"),
  ];
}
