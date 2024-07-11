import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/place_holder.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/shimmer_widget.dart';

import 'package:sizer/sizer.dart';


class VerticalNotificationsShimmer extends StatelessWidget {
  const VerticalNotificationsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const NotificationItemShimmer();
        });
  }
}

class NotificationItemShimmer extends StatelessWidget {
  const NotificationItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
        height: 12.h,
        width: 85.w,
        placeholder: Container(
          //  padding: EdgeInsets.all(10.sp),
          clipBehavior: Clip.hardEdge,
          width: 90.w,
          height: 27.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(180), border: Border.all()),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(5.sp),
                child: ShimmerPlaceHolder(
                  height: 20.w,
                  width: 20.w,
                  borderRadius: 360,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                child: ShimmerPlaceHolder(
                                  height: 3.h,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                            ],
                          )),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      ShimmerPlaceHolder(
                        width: 25.w,
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
