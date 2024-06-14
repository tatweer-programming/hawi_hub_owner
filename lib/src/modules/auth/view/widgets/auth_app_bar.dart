import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/widgets.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

class AuthAppBar extends StatelessWidget {
  final BuildContext context;
  final Owner owner;
  final String title;
  final Widget? widget;

  const AuthAppBar(
      {super.key,
      required this.context,
      required this.owner,
      this.widget,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CustomAppBar(
          blendMode: BlendMode.exclusion,
          backgroundImage: "assets/images/app_bar_backgrounds/4.webp",
          height: 32.h,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                backIcon(context),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorManager.white,
                    fontSize: 32.sp,
                  ),
                ),
                widget ??
                    SizedBox(
                      width: 10.w,
                    ),
              ],
            ),
          ),
        ),
        CircleAvatar(
          radius: 50.sp,
          backgroundColor: ColorManager.grey3,
          backgroundImage: owner.profilePictureUrl != null
              ? NetworkImage(owner.profilePictureUrl!)
              : const AssetImage("assets/images/icons/user.png")
                  as ImageProvider<Object>,
        ),
      ],
    );
  }
}
