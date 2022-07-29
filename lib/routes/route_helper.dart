import 'package:foody/pages/cart/cart_page.dart';
import 'package:foody/pages/food/popular_food_details.dart';
import 'package:foody/pages/food/recommended_food_details.dart';
import 'package:foody/pages/home/home_page.dart';
import 'package:foody/pages/home/main_food_page.dart';
import 'package:foody/pages/splash/splash_page.dart';
import 'package:get/route_manager.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popular = "/popular-food";
  static const String recommended = "/recommended-food";
  static const String _cart = "/cart";
  static const String _splash = "/splash";

  static String getPopular(int pageId) => "$popular?pageId=$pageId";
  static String getRecommended(int pageId) => "$recommended?pageId=$pageId";
  static String getInitial() => initial;
  static String get cart => _cart;
  static String get splash => _splash;

  static List<GetPage> routes = [
    GetPage(name: _splash, page: () => const SplashPage()),
    GetPage(
        name: initial,
        page: () {
          return const HomePage();
        }),
    GetPage(
        name: popular,
        page: () {
          int pageId = int.parse(Get.parameters["pageId"]!);
          return PopularFoodDetails(pageId: pageId);
        }),
    GetPage(
        name: recommended,
        page: () {
          int pageId = int.parse(Get.parameters["pageId"]!);
          return RecommendedFoodDetails(pageId: pageId);
        }),
    GetPage(name: _cart, page: () => const CartPage())
  ];
}
