import 'package:foody/controllers/cart_controller.dart';
import 'package:foody/controllers/popular_product_controller.dart';
import 'package:foody/controllers/recommended_product_controller.dart';
import 'package:foody/controllers/user_controller.dart';
import 'package:foody/data/api/api_client.dart';
import 'package:foody/data/repository/card_repo.dart';
import 'package:foody/data/repository/popular_product_repo.dart';
import 'package:foody/data/repository/recommended_product_repo.dart';
import 'package:foody/services/auth.dart';
import 'package:foody/services/cart.dart';
import 'package:foody/services/popular_product.dart';
import 'package:foody/services/recommended_product.dart';
import 'package:foody/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final _sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => _sharedPreferences);

  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => AuthService());
  Get.lazyPut(() => PopularProductService());
  Get.lazyPut(() => RecommendedProductService());
  Get.lazyPut(() => CartService());
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  // Get.put(CartRepo());

  Get.lazyPut(
      () => PopularProductController(popularProductService: Get.find()));
  Get.lazyPut(() =>
      RecommendedProductController(recommendedProductService: Get.find()));
  Get.lazyPut(
      () => CartController(cartRepo: Get.find(), cartService: Get.find()));
  Get.lazyPut(() => UserController(authService: Get.find()));
  // Get.put(CartController(cartRepo: Get.find()));
}
