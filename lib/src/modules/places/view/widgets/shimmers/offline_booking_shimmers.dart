import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/place_holder.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/shimmer_widget.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/offline_booking.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/offline_booking.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/offline_booking.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/offline_booking.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/offline_booking.dart';
import 'package:sizer/sizer.dart';

class VerticalOfflineBookingsShimmer extends StatelessWidget {
  const VerticalOfflineBookingsShimmer({super.key});

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
            return const OfflineBookingItemShimmers();
          }),
    );
  }
//
}

class OfflineBookingItemShimmers extends StatelessWidget {
  const OfflineBookingItemShimmers({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
        height: 15.h,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: ShimmerPlaceHolder(
                        width: 30.w,
                        height: 2.h,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.calendar_month),
                    SizedBox(width: 1.w),
                    ShimmerPlaceHolder(
                      width: 30.w,
                      height: 2.h,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.watch_later_outlined),
                    SizedBox(width: 1.w),
                    ShimmerPlaceHolder(
                      width: 30.w,
                      height: 2.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
