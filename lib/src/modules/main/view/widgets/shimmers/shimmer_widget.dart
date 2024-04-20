import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utils/color_manager.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget placeholder;
  final double height;
  final double width;
  const ShimmerWidget(
      {super.key, required this.placeholder, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
          baseColor: ColorManager.shimmerBaseColor,
          highlightColor: ColorManager.shimmerHighlightColor,
          enabled: true,
          child: placeholder),
    );
  }
}
