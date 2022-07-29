import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foody/controllers/cart_controller.dart';
import 'package:foody/controllers/popular_product_controller.dart';
import 'package:foody/controllers/recommended_product_controller.dart';
import 'package:foody/routes/route_helper.dart';
import 'package:foody/utils/app_constants.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/app_icon.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var cart = Get.find<CartController>();
    var cart = Get.find<CartController>();
    cart.initLocalCart();
    var popularProductList =
        Get.find<PopularProductController>().popularProductList;
    var recommendedProductList =
        Get.find<RecommendedProductController>().recommendedProductList;
    return Scaffold(
        body: Stack(children: [
          //Top tool bar
          Positioned(
              top: 4 * Dimensions.height10,
              left: Dimensions.width10,
              right: Dimensions.width10,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () => Get.back(),
                        child: AppIcon(
                            icon: Icons.arrow_back_ios_outlined,
                            backgroundColor: Colors.teal,
                            iconColor: Colors.white,
                            iconSize: Dimensions.iconSize24)),
                    SizedBox(width: 8 * Dimensions.width10),
                    InkWell(
                        onTap: () => Get.toNamed(RouteHelper.initial),
                        child: AppIcon(
                            icon: Icons.home_outlined,
                            backgroundColor: Colors.teal,
                            iconColor: Colors.white,
                            iconSize: Dimensions.iconSize24)),
                    InkWell(
                        child: AppIcon(
                            icon: Icons.shopping_cart,
                            backgroundColor: Colors.teal,
                            iconColor: Colors.white,
                            iconSize: Dimensions.iconSize24))
                  ])),
          //Cart list section
          Positioned(
              top: 10 * Dimensions.height10,
              left: 2 * Dimensions.width10,
              right: 2 * Dimensions.width10,
              bottom: 0,
              child: GetBuilder<CartController>(builder: (cart) {
                var cartItemList = cart.cartItemList;
                return cart.cartItemCount > 0
                    ? ListView.builder(
                        itemCount: cart.cartItemCount,
                        itemBuilder: ((context, index) => Container(
                            margin: EdgeInsets.only(
                                bottom: 2 * Dimensions.height10),
                            width: double.maxFinite,
                            height: 10 * Dimensions.height10,
                            child: Row(
                              children: [
                                // Cart Item Image
                                InkWell(
                                  onTap: () {
                                    var popularIndex = popularProductList
                                        .indexWhere((element) =>
                                            element.id ==
                                            cartItemList[index].id);
                                    if (popularIndex >= 0) {
                                      Get.toNamed(
                                          RouteHelper.getPopular(popularIndex));
                                    } else {
                                      var recommendeIndex =
                                          recommendedProductList.indexWhere(
                                              (element) =>
                                                  element.id ==
                                                  cartItemList[index].id);
                                      Get.toNamed(RouteHelper.getRecommended(
                                          recommendeIndex));
                                    }
                                  },
                                  child: Container(
                                      height: 10 * Dimensions.height10,
                                      width: 10 * Dimensions.height10,
                                      decoration: BoxDecoration(
                                          color: Colors.orangeAccent,
                                          borderRadius: BorderRadius.circular(
                                              2 * Dimensions.radius10),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "${AppConstants.baseUrl}uploads/${cartItemList[index].img}")))),
                                ),
                                SizedBox(width: 1.5 * Dimensions.width10),
                                // Cart Item details
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Cart Item title
                                    BigText(text: cartItemList[index].name!),
                                    // Cart item description
                                    const SmallText(text: "spicy"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Cart Item price
                                        BigText(
                                          text:
                                              "\$ ${cartItemList[index].price! * cartItemList[index].quantity!}",
                                          color: Colors.redAccent,
                                        ),
                                        // Cart item quatity increment and decrement tool
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  cart.decrementCartQuantity =
                                                      cart.cartItemList[index];
                                                },
                                                child:
                                                    const Icon(Icons.remove)),
                                            GetBuilder<CartController>(
                                                builder: (cartController) {
                                              return BigText(
                                                  text:
                                                      "${cartItemList[index].quantity!}");
                                            }),
                                            InkWell(
                                                onTap: () {
                                                  cart.incrementCartQuantity =
                                                      cart.cartItemList[index];
                                                },
                                                child: const Icon(Icons.add)),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                              ],
                            ))))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            const BigText(
                              text: "No Items in the cart",
                            ),
                            SizedBox(height: 10 * Dimensions.height10)
                          ]);
              }))
        ]),
        bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(height: Dimensions.height10),
          Container(
            height: 11 * Dimensions.height10,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              vertical: 2.5 * Dimensions.height10,
              horizontal: 2 * Dimensions.height10,
            ),
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4 * Dimensions.radius10),
                  topRight: Radius.circular(4 * Dimensions.radius10),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Favorite button
                Container(
                    height: double.maxFinite,
                    width: 12 * Dimensions.width10,
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.75 * Dimensions.width10),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(2.25 * Dimensions.radius10),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: GetBuilder<CartController>(
                        builder: (cart) =>
                            BigText(text: "\$${cart.totalAmount}"))),

                // Add to cart
                GestureDetector(
                  onTap: () => cart.addToCartHistory(),
                  child: Container(
                    height: double.maxFinite,
                    width: 18 * Dimensions.width10,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.75 * Dimensions.width10),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(2.25 * Dimensions.radius10),
                      color: Colors.teal,
                    ),
                    child: GetBuilder<CartController>(
                        builder: (cartController) => const BigText(
                            text: "Buy Now", color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
