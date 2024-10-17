import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:sizer/sizer.dart';

class ImageWidget extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final double? borderRadius;
  final List<String>? imageUrls;

  const ImageWidget(this.url,
      {super.key, this.borderRadius, this.height, this.width, this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.viewImages, arguments: {
          "imageUrls": imageUrls ?? [url],
          "index": imageUrls != null ? imageUrls!.indexOf(url) : 0,
        });
      },
      child: Container(
        width: width ?? 100.w,
        height: height ?? 30.h,
        decoration: BoxDecoration(
          color: ColorManager.grey1,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          image: DecorationImage(
            onError: (__, _) => ColoredBox(
              color: ColorManager.grey1,
            ),
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
