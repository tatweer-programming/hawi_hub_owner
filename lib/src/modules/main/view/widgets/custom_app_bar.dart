import 'package:flutter/material.dart';
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
                    padding: EdgeInsets.only(top: 2.h, right: 2.w, left: 2.w, bottom: 1.h),
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
                SizedBox(height: 10.sp),
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
