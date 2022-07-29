import 'package:flutter/material.dart';
import 'package:foody/controllers/popular_product_controller.dart';
import 'package:foody/controllers/recommended_product_controller.dart';
import 'package:foody/pages/home/food_page_body.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/small_text.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
            child: Container(
                margin: EdgeInsets.only(
                    top: 4.5 * Dimensions.height10,
                    bottom: 1.5 * Dimensions.height10),
                padding: EdgeInsets.only(
                    left: 2 * Dimensions.width10,
                    right: 2 * Dimensions.width10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      const BigText(
                        text: "India",
                        color: Colors.teal,
                      ),
                      Row(children: const [
                        SmallText(text: "Irinjalakuda"),
                        Icon(Icons.arrow_drop_down_rounded)
                      ])
                    ]),
                    Center(
                        child: Container(
                            width: 4.5 * Dimensions.height10,
                            height: 4.5 * Dimensions.height10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  1.5 * Dimensions.radius10),
                              color: Colors.teal,
                            ),
                            child: Icon(Icons.search,
                                color: Colors.white,
                                size: Dimensions.iconSize24)))
                  ],
                ))),
        const Expanded(
          child: SingleChildScrollView(
            child: FoodPageBody(),
          ),
        ),
      ],
    ));
  }
}
