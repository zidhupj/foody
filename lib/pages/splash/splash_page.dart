import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foody/controllers/cart_controller.dart';
import 'package:foody/controllers/popular_product_controller.dart';
import 'package:foody/controllers/recommended_product_controller.dart';
import 'package:foody/routes/route_helper.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<PopularProductController>().getPopularProductList();
      Get.find<RecommendedProductController>().getRecommendedProductList();
      Get.find<CartController>().setCartFromLocalStorage = true;
      print(timeStamp);
    });

    Timer(const Duration(milliseconds: 1500),
        () => Get.offAndToNamed(RouteHelper.initial));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScaleTransition(
            scale: _animation,
            child: Center(child: Image.asset("assets/images/foody_logo.png"))));
  }
}
