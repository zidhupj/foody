import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody/utils/dimensions.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow textOverflow;

  const BigText(
      {Key? key,
      required this.text,
      this.color = const Color.fromARGB(255, 24, 24, 24),
      this.size = 0,
      this.textOverflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: textOverflow,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        letterSpacing: 1.3,
      ),
    );
  }
}
