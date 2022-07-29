import 'package:flutter/material.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/icon_and_text_widget.dart';
import 'package:foody/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: 2.7 * Dimensions.font10,
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => Icon(Icons.star,
                      color: Colors.teal, size: 1.7 * Dimensions.iconSize10)),
            ),
            SizedBox(width: Dimensions.width10),
            const SmallText(text: "4.5"),
            SizedBox(width: Dimensions.width10),
            const SmallText(text: "1287"),
            SizedBox(width: 0.5 * Dimensions.width10),
            const SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: 1.5 * Dimensions.height10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: Colors.orange.shade400),
            const IconAndTextWidget(
                icon: Icons.location_on_sharp,
                text: "1.7km",
                iconColor: Colors.teal),
            IconAndTextWidget(
                icon: Icons.access_time_rounded,
                text: "32min",
                iconColor: Colors.red.shade400)
          ],
        )
      ],
    );
  }
}
