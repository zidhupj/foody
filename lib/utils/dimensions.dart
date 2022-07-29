import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageViewContainer = screenHeight / 2.604;
  static double pageViewImageContainer = screenHeight / 3.55;
  static double pageViewTextContainer = screenHeight / 6.51;

  static double height10 = screenHeight / 78.11;
  static double width10 = screenWidth / 39.27;

  static double font20 = screenHeight / 39.05;
  static double font12 = screenHeight / 65.09;
  static double font10 = font20 / 2;

  static double radius10 = screenHeight / 78.11;

  static double iconSize10 = height10;
  static double iconSize24 = 2.4 * height10;
}
