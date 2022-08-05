import 'package:flutter/material.dart';
import 'package:foody/controllers/cart_controller.dart';
import 'package:foody/controllers/popular_product_controller.dart';
import 'package:foody/routes/route_helper.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/app_column.dart';
import 'package:foody/widgets/app_icon.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/expandable_text_widget.dart';
import 'package:foody/widgets/small_text.dart';
import 'package:get/get.dart';

class PopularFoodDetails extends StatelessWidget {
  final int pageId;
  const PopularFoodDetails({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    for (var i in Get.find<PopularProductController>().popularProductList) {
      print(i.name);
    }
    print(product.id);
    var cart = Get.find<CartController>();
    cart.initCurrentQuantity = 0;
    cart.initCartQuantity = product.id!;

    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        //Background image
        Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 35 * Dimensions.height10,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(product.img!),
              )),
            )),
        // Icon widgets
        Positioned(
            left: 2 * Dimensions.width10,
            right: 2 * Dimensions.width10,
            top: 1.5 * Dimensions.height10,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const AppIcon(icon: Icons.arrow_back_ios),
                  ),
                  InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.cart);
                      },
                      child: Stack(children: [
                        const AppIcon(icon: Icons.shopping_cart_outlined),
                        Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                                height: 2 * Dimensions.height10,
                                width: 2 * Dimensions.height10,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius10),
                                    color: Colors.teal),
                                child: GetBuilder<CartController>(
                                    builder: (cartController) {
                                  return SmallText(
                                    text: "${cart.cartQuantity}",
                                    color: Colors.white,
                                  );
                                })))
                      ]))
                ])),
        // Food Details
        Positioned(
          left: 0,
          right: 0,
          top: 35 * Dimensions.height10 - 5 * Dimensions.height10,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.only(
                left: 2 * Dimensions.width10,
                right: 2 * Dimensions.width10,
                top: 2 * Dimensions.height10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.5 * Dimensions.radius10),
              color: Colors.white,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AppColumn(
                text: product.name!,
              ),
              SizedBox(height: 2 * Dimensions.height10),
              BigText(
                text: "Introduce",
                size: 2.4 * Dimensions.font10,
              ),
              SizedBox(height: 1.25 * Dimensions.height10),
              Expanded(
                  child: SingleChildScrollView(
                      child: ExpandableTextWidget(text: product.description!)))
            ]),
          ),
        )
      ])),
      bottomNavigationBar: Container(
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
            // Add and remove food items
            Container(
                height: double.maxFinite,
                width: 10 * Dimensions.width10,
                padding:
                    EdgeInsets.symmetric(horizontal: 0.75 * Dimensions.width10),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(2.25 * Dimensions.radius10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          cart.decrementCurrentQuantity = 1;
                        },
                        child: const Icon(Icons.remove)),
                    GetBuilder<CartController>(builder: (cartController) {
                      return BigText(text: "${cart.currentQuantity}");
                    }),
                    InkWell(
                        onTap: () {
                          cart.incrementCurrentQuantity = 1;
                        },
                        child: const Icon(Icons.add)),
                  ],
                )),

            // Add to cart
            GetBuilder<CartController>(builder: (cartController) {
              return InkWell(
                  onTap: () {
                    cart.addToCart(product);
                  },
                  child: Container(
                      height: double.maxFinite,
                      width: 23 * Dimensions.width10,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.6 * Dimensions.width10),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(2.25 * Dimensions.radius10),
                        color: Colors.teal,
                      ),
                      child: BigText(
                          text:
                              "\$${product.price! * cart.currentQuantity} | Add to Cart",
                          color: Colors.white)));
            }),
          ],
        ),
      ),
    );
  }
}
