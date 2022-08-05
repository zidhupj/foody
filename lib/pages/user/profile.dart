import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foody/controllers/user_controller.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/profile_item.dart';
import 'package:foody/widgets/small_text.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var editName = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 5 * Dimensions.height10,
              horizontal: 3 * Dimensions.width10),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                // Profile Picture
                Container(
                  width: 26 * Dimensions.height10,
                  height: 26 * Dimensions.height10,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(13 * Dimensions.height10),
                      color: CupertinoColors.secondarySystemFill,
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmoonvillageassociation.org%2Fwp-content%2Fuploads%2F2018%2F06%2Fdefault-profile-picture1.jpg&f=1&nofb=1"))),
                ),
                SizedBox(height: 4 * Dimensions.height10),
                // Name
                GetBuilder<UserController>(
                  builder: (userController) {
                    var user = userController.user;
                    return user == null
                        ? Center(child: BigText(text: "No User"))
                        : Column(
                            children: [
                              ProfileItem(
                                changeValue: userController.editName,
                                hintText: "name",
                                text: user.displayName == null
                                    ? "---"
                                    : user.displayName!,
                                icon: CupertinoIcons.person_2_square_stack_fill,
                              ),
                              SizedBox(height: 3 * Dimensions.height10),
                              ProfileItem(
                                changeValue: null,
                                disableEdit: true,
                                hintText: "email",
                                text: user.email == null ? "---" : user.email!,
                                icon: CupertinoIcons.mail_solid,
                              ),
                              SizedBox(height: 3 * Dimensions.height10),
                            ],
                          );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
