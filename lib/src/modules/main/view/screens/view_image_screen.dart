import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/apis/api.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';

import 'package:sizer/sizer.dart';

class FullScreenImageGallery extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const FullScreenImageGallery(
      {required this.imageUrls, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    print(ApiManager.handleImageUrl(imageUrls[initialIndex]));
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: PageView.builder(
          controller: PageController(initialPage: initialIndex),
          // يبدأ من الصورة المحددة
          itemCount: imageUrls.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: ColorManager.black,
                image: DecorationImage(
                  image: NetworkImage(
                    imageUrls[index],
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
