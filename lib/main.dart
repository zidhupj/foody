import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foody/controllers/cart_controller.dart';
import 'package:foody/controllers/popular_product_controller.dart';
import 'package:foody/controllers/recommended_product_controller.dart';
import 'package:foody/controllers/user_controller.dart';
import 'package:foody/routes/route_helper.dart';
import 'package:foody/utils/app_constants.dart';
import 'package:get/get.dart';
import 'helpers/dependencies.dart' as dep;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
  Get.find<PopularProductController>();
  Get.find<RecommendedProductController>();
  Get.find<CartController>();
  Get.find<UserController>();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      // home: AuthPage(),
      initialRoute: RouteHelper.splash,
      getPages: RouteHelper.routes,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
