import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/place_holder.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class VerticalAppBookingsShimmer extends StatelessWidget {
  const VerticalAppBookingsShimmer({super.key});

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
            return const AppBookingItemShimmers();
          }),
    );
  }
//
}

class AppBookingItemShimmers extends StatelessWidget {
  const AppBookingItemShimmers({super.key});

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
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     const Spacer(),
              //     InkWell(
              //       onTap: () {
              //         context.push(Routes.bookingRequestDetails,
              //             arguments: {"id": bookingRequest.id});
              //       },
              //       child: Text(S.of(context).viewDetails,
              //           style: TextStyleManager.getGoldenRegularStyle()),
              //     ),
              //     const Icon(
              //       Icons.arrow_forward,
              //       color: ColorManager.golden,
              //     )
              //   ],
              // ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: FittedBox(
                            child: CircleAvatar(),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        ShimmerPlaceHolder(
                          width: 30.w,
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                      flex: 3,
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
                      ))
                ],
              )),
            ],
          ),
        ));
  }
}
