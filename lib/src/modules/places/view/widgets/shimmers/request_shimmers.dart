import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/place_holder.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class VerticalRequestsShimmer extends StatelessWidget {
  const VerticalRequestsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.w),
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                height: 2.h,
              ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return const RequestItemShimmers();
          }),
    );
  }
//
}

class HorizontalRequestsShimmer extends StatelessWidget {
  const HorizontalRequestsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                width: 4.w,
              ),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return const RequestItemShimmers();
          }),
    );
  }
}

class RequestItemShimmers extends StatelessWidget {
  const RequestItemShimmers({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
        height: 20.h,
        width: 85.w,
        placeholder: Container(
          padding: const EdgeInsets.all(15),
          height: 20.h,
          width: 90.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ColorManager.black, width: .6),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  ShimmerPlaceHolder(
                    width: 30.w,
                    height: 2.h,
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 10.w,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                          child: ShimmerPlaceHolder(
                        height: 3.h,
                      ))
                    ],
                  )),
              SizedBox(height: 2.h),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ShimmerPlaceHolder(
                          height: 5.h,
                          borderRadius: 20,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: ShimmerPlaceHolder(
                          height: 5.h,
                          borderRadius: 20,
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 1.h),
            ],
          ),
        ));
  }
}
