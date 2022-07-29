import 'package:flutter/widgets.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final double iconSize;
  final double textSize;
  const IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor,
      this.iconSize = 0,
      this.textSize = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,
            color: iconColor,
            size: iconSize == 0 ? Dimensions.iconSize24 : iconSize),
        const SizedBox(width: 5),
        SmallText(
            text: text, size: textSize == 0 ? Dimensions.font12 : textSize)
      ],
    );
  }
}
