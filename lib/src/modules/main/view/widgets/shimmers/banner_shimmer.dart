import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/place_holder.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/shimmers/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class BannersShimmer extends StatelessWidget {
  const BannersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) => ShimmerWidget(
          height: 20.h,
          width: 88.w,
          // enabled: true,
          placeholder: ShimmerPlaceHolder(
            width: 88.w,
            height: 19.h,
            // margin: const EdgeInsets.symmetric(horizontal: 5.0),
            borderRadius: 20,
          )),
    );
  }
}
