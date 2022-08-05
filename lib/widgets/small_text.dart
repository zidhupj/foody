import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody/utils/dimensions.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  const SmallText(
      {Key? key,
      required this.text,
      this.color = const Color.fromARGB(255, 117, 117, 117),
      this.size = 0,
      this.height = 1.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        textBaseline: TextBaseline.alphabetic,
        color: color,
        fontSize: size == 0 ? Dimensions.font12 : size,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        fontFamily: 'Roboto',
        height: height,
      ),
    );
  }
}
