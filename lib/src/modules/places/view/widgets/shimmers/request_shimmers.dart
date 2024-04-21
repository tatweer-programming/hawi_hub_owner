import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/place_holder.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class VerticalRequestsShimmer extends StatelessWidget {
  const VerticalRequestsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return const RequestItemShimmers();
        });
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
          padding: const EdgeInsets.all(10),
          width: 90.w,
          height: 27.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all()),
          child: Column(
            children: [
              ShimmerPlaceHolder(
                height: 15.h,
                borderRadius: 15,
              ),
              SizedBox(height: 1.h),
              Row(children: [
                ShimmerPlaceHolder(
                  width: 45.w,
                  height: 2.5.h,
                  borderRadius: 5,
                ),
                const Spacer(),
                ShimmerPlaceHolder(
                  width: 25.w,
                  height: 2.5.h,
                  borderRadius: 5,
                ),
              ]),
              SizedBox(height: 1.h),
              const ShimmerPlaceHolder(
                borderRadius: 5,
              ),
              SizedBox(height: 1.h),
              const ShimmerPlaceHolder(
                borderRadius: 5,
              ),
            ],
          ),
        ));
  }
}
