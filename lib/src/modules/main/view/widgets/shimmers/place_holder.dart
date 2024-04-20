import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:sizer/sizer.dart';

class ShimmerPlaceHolder extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final dynamic customBorderRadius;
  const ShimmerPlaceHolder(
      {super.key, this.height, this.width, this.borderRadius, this.customBorderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? 1.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: ColorManager.shimmerBaseColor,
          borderRadius: customBorderRadius ?? BorderRadius.circular(borderRadius ?? 0),
        ));
  }
}
