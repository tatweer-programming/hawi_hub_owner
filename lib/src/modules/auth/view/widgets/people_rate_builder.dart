import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';
import 'package:sizer/sizer.dart';

class PeopleRateBuilder extends StatelessWidget {
  final BuildContext context;
  final AppFeedBack feedBack;

  const PeopleRateBuilder({
    super.key,
    required this.context,
    required this.feedBack,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Container(
              height: 12.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.sp),
                  border: Border.all()),
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 3.w, vertical: 1.h),
                child: Row(children: [
                  CircleAvatar(
                    radius: 20.sp,
                    backgroundColor: ColorManager.grey3,
                    backgroundImage: feedBack.userImageUrl != null
                        ? NetworkImage(feedBack.userImageUrl!)
                        : const AssetImage("assets/images/icons/user.png")
                            as ImageProvider<Object>,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Expanded(
                    child: Text(feedBack.comment ?? S.of(context).noComment,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorManager.black.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ]),
              ),
            ),
          ],
        ),
        Positioned(
          left: 5.w,
          top: -1.h,
          child: Container(
            padding: EdgeInsetsDirectional.symmetric(
              vertical: 1.h,
              horizontal: 2.w,
            ),
            color: Colors.white,
            child: Row(
              children: [
                Text(
                  feedBack.userName ?? "",
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.green,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 1.w),
                RatingBar.builder(
                  initialRating: feedBack.rating,
                  minRating: 1,
                  itemSize: 10.sp,
                  direction: Axis.horizontal,
                  ignoreGestures: true,
                  allowHalfRating: true,
                  itemPadding: EdgeInsets.zero,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: ColorManager.golden,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
