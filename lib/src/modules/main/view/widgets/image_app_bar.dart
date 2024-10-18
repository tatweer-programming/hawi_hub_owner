import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:sizer/sizer.dart';

class ImageAppBar extends StatelessWidget {
  final String title;
  final String imagePath;

  const ImageAppBar({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 42.h,
        width: 100.w,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                height: 42.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: ColorManager.grey1,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(imagePath))),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.black.withOpacity(.2),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
