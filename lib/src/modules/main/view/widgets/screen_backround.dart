import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/apis/api.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/image_widget.dart';
import 'package:sizer/sizer.dart';

class ScreenBackground extends StatelessWidget {
  final String screenImage;
  final String screenTitle;
  final Widget child;

  const ScreenBackground(
      {super.key,
      required this.screenImage,
      required this.screenTitle,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: [
        SizedBox(
          height: 42.h,
          width: 100.w,
          child: Stack(
            children: [
              Positioned.fill(
                child: ImageWidget(
                  ApiManager.handleImageUrl(screenImage),
                  height: 42.h,
                  width: 100.w,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.black.withOpacity(.2),
                  ),
                  child: Center(
                    child: Text(
                      screenTitle,
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
        Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      child
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ]),
    );
  }
}
