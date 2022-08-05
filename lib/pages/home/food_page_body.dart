import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foody/controllers/popular_product_controller.dart';
import 'package:foody/controllers/recommended_product_controller.dart';
import 'package:foody/models/product_list_model.dart';
import 'package:foody/routes/route_helper.dart';
import 'package:foody/utils/app_constants.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/app_column.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/icon_and_text_widget.dart';
import 'package:foody/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewImageContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Slider Section
      GetBuilder<PopularProductController>(builder: (popularProducts) {
        List<ProductItem> popularProductList =
            popularProducts.popularProductList;
        return popularProducts.isLoaded
            ? Column(children: [
                SizedBox(
                    height: Dimensions.pageViewContainer,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: popularProductList.length,
                        itemBuilder: ((context, index) =>
                            _buildPageItem(index, popularProductList[index])))),

                SizedBox(height: 1.5 * Dimensions.height10),

                // Slider dots indicator
                DotsIndicator(
                  dotsCount: popularProductList.isEmpty
                      ? 1
                      : popularProductList.length,
                  position: _currPageValue,
                  decorator: DotsDecorator(
                    activeColor: Colors.teal,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ])
            : const CircularProgressIndicator(color: Colors.teal);
      }),

      SizedBox(height: 1.5 * Dimensions.height10),

      // Popular Heading
      Container(
        margin: EdgeInsets.only(left: 3 * Dimensions.width10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const BigText(text: "Recomended"),
            SizedBox(width: Dimensions.width10),
            Container(
                margin: EdgeInsets.only(bottom: 0.20 * Dimensions.font20),
                child: const BigText(text: ".", color: Colors.black26)),
            SizedBox(width: Dimensions.width10),
            Container(
                margin: EdgeInsets.only(bottom: 0.1 * Dimensions.font20),
                child: const SmallText(
                    text: "Food Pairing", color: Colors.black26)),
          ],
        ),
      ),

      // list of food items
      GetBuilder<RecommendedProductController>(builder: (recommendedProducts) {
        var recommendedProductList = recommendedProducts.recommendedProductList;

        return recommendedProducts.isLoaded
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recommendedProductList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getRecommended(index));
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            left: 2 * Dimensions.width10,
                            right: 2.5 * Dimensions.width10,
                            bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            Container(
                                width: 12 * Dimensions.height10,
                                height: 12 * Dimensions.height10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      2 * Dimensions.radius10),
                                  color: Colors.grey.shade400,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        recommendedProductList[index].img!),
                                  ),
                                )),
                            Expanded(
                                child: Container(
                              height: 10 * Dimensions.height10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(2 * Dimensions.radius10),
                                  bottomRight:
                                      Radius.circular(2 * Dimensions.radius10),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10,
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      BigText(
                                          text: recommendedProductList[index]
                                              .name!),
                                      SmallText(
                                          text: recommendedProductList[index]
                                              .name!),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconAndTextWidget(
                                            icon: Icons.circle_sharp,
                                            text: "Normal",
                                            iconColor: Colors.orange.shade400,
                                            iconSize:
                                                0.75 * Dimensions.iconSize24,
                                          ),
                                          IconAndTextWidget(
                                            icon: Icons.location_on_sharp,
                                            text: "1.7km",
                                            iconColor: Colors.teal,
                                            iconSize:
                                                0.75 * Dimensions.iconSize24,
                                          ),
                                          IconAndTextWidget(
                                            icon: Icons.access_time_rounded,
                                            text: "32min",
                                            iconColor: Colors.red.shade400,
                                            iconSize:
                                                0.75 * Dimensions.iconSize24,
                                          )
                                        ],
                                      )
                                    ]),
                              ),
                            ))
                          ],
                        )),
                  );
                })
            : const CircularProgressIndicator(color: Colors.teal);
      })
    ]);
  }

  Widget _buildPageItem(int index, ProductItem popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    double currScale = _scaleFactor;
    if (index == _currPageValue.floor()) {
      currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
    } else if (index == _currPageValue.floor() + 1) {
      currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
    } else if (index == _currPageValue.floor() - 1) {
      currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
    }
    double currTrans = _height * (1 - currScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, currTrans, 0);

    // print("${AppConstants.baseUrl}uploads/${popularProduct.img!}");

    return GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.getPopular(index));
        },
        child: Transform(
            transform: matrix,
            child: Stack(children: [
              Container(
                  height: _height,
                  margin: EdgeInsets.only(
                      left: Dimensions.width10, right: Dimensions.width10),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(3 * Dimensions.radius10),
                      color: index % 2 == 0
                          ? Colors.deepPurple[200]
                          : Colors.lightGreen[300],
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(popularProduct.img!)))),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: Dimensions.pageViewTextContainer,
                      margin: EdgeInsets.only(
                          left: 2.1 * Dimensions.width10,
                          right: 2.1 * Dimensions.width10,
                          bottom: 2 * Dimensions.height10),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(3 * Dimensions.radius10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xFFe8e8e8),
                                blurRadius: 5.0,
                                offset: Offset(0, 5))
                          ]),
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 1.5 * Dimensions.height10,
                              left: 2 * Dimensions.width10,
                              right: 2 * Dimensions.width10),
                          child: AppColumn(
                            text: popularProduct.name!,
                          ))))
            ])));
  }
}
