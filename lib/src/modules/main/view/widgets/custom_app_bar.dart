import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/chat/view/screens/chats_screen.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';

class CustomAppBar extends StatelessWidget {
  final Widget child;
  final List<Widget>? actions;
  final double height;
  final String? backgroundImage;
  final double? opacity;
  final BlendMode? blendMode;
  final Color? color;

  const CustomAppBar({
    super.key,
    required this.child,
    required this.height,
    this.backgroundImage,
    this.actions,
    this.opacity,
    this.blendMode,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipPath(
        clipper: CustomAppBarClipper(),
        child: Container(
          decoration: BoxDecoration(
            image: backgroundImage != null
                ? DecorationImage(
                    fit: BoxFit.fill,
                    opacity: opacity ?? .1,
                    colorFilter: ColorFilter.mode(
                      color ?? ColorManager.transparent,
                      blendMode ?? BlendMode.colorDodge,
                    ),
                    image: AssetImage(
                      backgroundImage!,
                    ),
                  )
                : null,
            color: ColorManager.primary,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (actions != null)
                  Padding(
                    padding: EdgeInsets.only(
                        top: 2.h, right: 2.w, left: 2.w, bottom: 1.h),
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: actions!
                              .map((e) => Padding(
                                    padding: EdgeInsets.all(1.sp),
                                    child: e,
                                  ))
                              .toList()),
                    ),
                  ),
                SizedBox(height: 5.sp),
                child,
                SizedBox(height: height * .3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * .9);
    path.quadraticBezierTo(
      size.width * .125,
      size.height * .8,
      size.width * .25,
      size.height * .79,
    );
    path.quadraticBezierTo(
      size.width * .5,
      size.height * .75,
      size.width * .65,
      size.height * .83,
    );
    path.quadraticBezierTo(
      size.width * .875,
      size.height * .95,
      size.width,
      size.height * .9,
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MainCubit mainCubit = MainCubit.get();
    return SafeArea(
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                context.pushWithTransition(const ChatsScreen());
              },
              icon: const ImageIcon(
                AssetImage("assets/images/icons/chat.png"),
                color: ColorManager.golden,
              )),
          InkWell(
            radius: 360,
            onTap: () {
              context.push(
                Routes.profile,
                arguments: {
                  'id': ConstantsManager.userId,
                  "userType": "Player"
                },
              );
            },
            child: CircleAvatar(
              backgroundColor: ColorManager.grey3,
              backgroundImage: ConstantsManager.appUser != null &&
                      ConstantsManager.appUser!.profilePictureUrl != null
                  ? NetworkImage(ConstantsManager.appUser!.profilePictureUrl!)
                  : const AssetImage("assets/images/icons/user.png")
                      as ImageProvider<Object>,
            ),
          ),
          IconButton(
              onPressed: () {
                context.push(Routes.notifications);
              },
              icon: const ImageIcon(
                AssetImage("assets/images/icons/notification.webp"),
                color: ColorManager.golden,
              )),
          const Spacer(),
        ],
      ),
    );
  }
}
