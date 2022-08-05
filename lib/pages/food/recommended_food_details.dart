import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/controllers/cart_controller.dart';
import 'package:foody/controllers/recommended_product_controller.dart';
import 'package:foody/routes/route_helper.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/app_icon.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/expandable_text_widget.dart';
import 'package:foody/widgets/small_text.dart';
import 'package:get/get.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetails({Key? key, required this.pageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    var cart = Get.find<CartController>();
    cart.initCurrentQuantity = 1;
    cart.initCartQuantity = product.id!;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              backgroundColor: CupertinoColors.secondaryLabel,
              expandedHeight: 30 * Dimensions.height10,
              toolbarHeight: 7 * Dimensions.height10,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(product.img!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Expanded(
                        child: ColoredBox(color: CupertinoColors.systemTeal))),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const AppIcon(icon: Icons.clear)),
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
                ],
              ),
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(2 * Dimensions.height10),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                        vertical: 0.7 * Dimensions.height10,
                        horizontal: 1 * Dimensions.width10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(1.5 * Dimensions.radius10),
                          topRight: Radius.circular(1.5 * Dimensions.radius10),
                        ),
                        color: Colors.white),
                    child: BigText(text: product.name!),
                  )),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.5 * Dimensions.width10,
                      ),
                      child: ExpandableTextWidget(
                        text: product.description!,
                      ))
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(height: Dimensions.height10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => cart.decrementCurrentQuantity = 1,
                child: AppIcon(
                  icon: Icons.remove,
                  backgroundColor: Colors.teal,
                  iconColor: Colors.white,
                  size: 5 * Dimensions.height10,
                  iconSize: 3 * Dimensions.height10,
                ),
              ),
              GetBuilder<CartController>(
                builder: (cartController) => BigText(
                  text: "\$${product.price} X ${cart.currentQuantity}",
                  size: 2.75 * Dimensions.font10,
                ),
              ),
              GestureDetector(
                onTap: () => cart.incrementCurrentQuantity = 1,
                child: AppIcon(
                  icon: Icons.add,
                  backgroundColor: Colors.teal,
                  iconColor: Colors.white,
                  size: 5 * Dimensions.height10,
                  iconSize: 3 * Dimensions.height10,
                ),
              ),
            ],
          ),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Favorite button
                Container(
                    height: double.maxFinite,
                    width: 6.5 * Dimensions.width10,
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.75 * Dimensions.width10),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(2.25 * Dimensions.radius10),
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.favorite, color: Colors.teal)),

                // Add to cart
                GestureDetector(
                  onTap: () => cart.addToCart(product),
                  child: Container(
                    height: double.maxFinite,
                    width: 24 * Dimensions.width10,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.75 * Dimensions.width10),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(2.25 * Dimensions.radius10),
                      color: Colors.teal,
                    ),
                    child: GetBuilder<CartController>(
                        builder: (cartController) => BigText(
                            text:
                                "\$${product.price! * cart.currentQuantity} | Add to Cart",
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
