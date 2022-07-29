import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = 22 * Dimensions.height10;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt() + 1);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? SmallText(text: firstHalf)
            : Column(
                children: [
                  SmallText(
                    text:
                        hiddenText ? "$firstHalf..." : "$firstHalf$secondHalf",
                    height: 1.6,
                    size: 1.5 * Dimensions.font10,
                  ),
                  SizedBox(height: Dimensions.height10),
                  InkWell(
                      onTap: () {
                        setState(() {
                          hiddenText = !hiddenText;
                        });
                      },
                      child: Row(
                        children: [
                          SmallText(
                            text: hiddenText ? "Show More" : "Show Less",
                            color: Colors.teal,
                            size: 1.5 * Dimensions.font10,
                          ),
                          Icon(
                            hiddenText
                                ? Icons.keyboard_arrow_down_rounded
                                : Icons.keyboard_arrow_up_rounded,
                            color: Colors.teal,
                            size: 1.5 * Dimensions.font10,
                          )
                        ],
                      )),
                  SizedBox(height: 3 * Dimensions.height10),
                ],
              ));
  }
}
