import 'package:flutter/cupertino.dart';
import 'package:foody/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  const AppIcon({
    Key? key,
    required this.icon,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.size = 0,
    this.iconSize = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size == 0 ? 4 * Dimensions.height10 : size,
      height: size == 0 ? 4 * Dimensions.height10 : size,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
              size == 0 ? 2 * Dimensions.height10 : size / 2)),
      child: Center(
          child: Icon(
        icon,
        size: iconSize == 0 ? 1.6 * Dimensions.height10 : iconSize,
        color: iconColor,
      )),
    );
  }
}
