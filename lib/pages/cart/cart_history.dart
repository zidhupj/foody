import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/controllers/cart_controller.dart';
import 'package:foody/utils/app_constants.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/app_icon.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Get.find<CartController>();
    cart.getHistoryList();
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Container(
          height: 6.5 * Dimensions.height10,
          color: Colors.teal,
          padding: EdgeInsets.symmetric(horizontal: 1.5 * Dimensions.width10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 4 * Dimensions.height10),
                BigText(
                  text: "Your Orders",
                  color: Colors.white,
                  size: 2.25 * Dimensions.font10,
                ),
                AppIcon(
                  icon: CupertinoIcons.cart_fill,
                  iconColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  iconSize: 2.25 * Dimensions.font10,
                )
              ])),
      GetBuilder<CartController>(builder: (cart) {
        int counter = 0;
        List<int> cartOrderTimeList = cart.cartOrderTimeList.reversed.toList();
        var historyList = cart.cartHistory.reversed.toList();
        // print(cart.cartHistory);
        return Expanded(
            child: ListView.builder(
                itemCount: cartOrderTimeList.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    SizedBox(height: 2 * Dimensions.height10),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10),
                        height: 12 * Dimensions.height10,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (() {
                                var dateFormat =
                                    DateFormat("dd/MM/yyyy hh:mm a");
                                return BigText(
                                    text: dateFormat.format(DateTime.parse(
                                        historyList[counter].time!)));
                              }()),
                              Expanded(
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: cartOrderTimeList[index],
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, i) {
                                            return Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width:
                                                        8 * Dimensions.height10,
                                                    height:
                                                        8 * Dimensions.height10,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius10),
                                                        color: i % 2 == 0
                                                            ? Colors
                                                                .orangeAccent
                                                            : Colors
                                                                .greenAccent,
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                "${AppConstants.baseUrl}uploads/${historyList[counter++].img}"))),
                                                  ),
                                                  SizedBox(
                                                      width: Dimensions.width10)
                                                ]);
                                          }),
                                    ),
                                    SizedBox(width: 2 * Dimensions.width10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const SmallText(text: "Total"),
                                        BigText(
                                            text:
                                                "${cartOrderTimeList[index]} items"),
                                        // SizedBox(
                                        //     height: 3.5 * Dimensions.height10,
                                        //     child: CupertinoButton(
                                        //         padding: EdgeInsets.symmetric(
                                        //             vertical:
                                        //                 Dimensions.height10,
                                        //             horizontal:
                                        //                 Dimensions.width10),
                                        //         color: Colors.teal,
                                        //         onPressed: () {},
                                        //         child: SmallText(
                                        //           text: "See more",
                                        //           color: Colors.white,
                                        //           size: 1.5 * Dimensions.font10,
                                        //         )))
                                      ],
                                    )
                                  ])),
                            ]))
                  ]);
                }));
      })
    ])));
  }
}
