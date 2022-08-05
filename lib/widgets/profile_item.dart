import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/small_text.dart';

class ProfileItem extends StatefulWidget {
  final Future<dynamic> Function(String)? changeValue;
  final IconData icon;
  final String hintText;
  final String text;
  final bool disableEdit;

  const ProfileItem({
    Key? key,
    required this.changeValue,
    required this.icon,
    required this.hintText,
    required this.text,
    this.disableEdit = false,
  }) : super(key: key);

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  var edit = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("display name: ${widget.text}");
    return edit
        ? SizedBox(
            child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () async {
                          if (widget.changeValue != null) {
                            await widget.changeValue!(controller.text);
                          }
                          setState(() {
                            edit = false;
                          });
                        },
                        child: Icon(
                          CupertinoIcons.checkmark_alt_circle_fill,
                          color: Colors.teal,
                          size: 3.5 * Dimensions.font10,
                        )),
                    hintText: widget.hintText,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)))),
          )
        : Container(
            padding: EdgeInsets.only(bottom: 0.5 * Dimensions.height10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.teal, width: 0.2 * Dimensions.height10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Icon(widget.icon, size: 3.5 * Dimensions.font10),
                      SizedBox(width: Dimensions.width10),
                      SmallText(
                          text: "${widget.hintText}:",
                          size: 2 * Dimensions.font10)
                    ]),
                SizedBox(width: Dimensions.width10),
                Expanded(
                  child: Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Expanded(
                          child: BigText(
                              text: widget.text, size: 2.5 * Dimensions.font10),
                        ),
                        SizedBox(width: Dimensions.width10),
                        widget.disableEdit
                            ? InkWell(
                                onTap: () {},
                                child: Icon(CupertinoIcons.pencil_slash,
                                    size: 3.5 * Dimensions.font10),
                              )
                            : InkWell(
                                onTap: () => setState(() {
                                  edit = true;
                                }),
                                child: Icon(
                                    CupertinoIcons.pencil_ellipsis_rectangle,
                                    size: 3.5 * Dimensions.font10),
                              )
                      ]),
                )
              ],
            ));
  }
}
