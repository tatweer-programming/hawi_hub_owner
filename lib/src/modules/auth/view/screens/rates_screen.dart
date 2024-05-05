import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../main/view/widgets/custom_app_bar.dart';
import '../widgets/widgets.dart';

class RatesScreen extends StatelessWidget {
  final Owner owner;

  const RatesScreen({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                _appBar(context, owner.profilePictureUrl),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 5.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  owner.userName,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "People Rate",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2.h,
                ),
                if (owner.feedbacks.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            _peopleRateBuilder(owner.feedbacks[index], context),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 2.h,
                            ),
                        itemCount: owner.feedbacks.length),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _appBar(
  BuildContext context,
  String? profilePictureUrl,
) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      CustomAppBar(
        blendMode: BlendMode.exclusion,
        backgroundImage: "assets/images/app_bar_backgrounds/4.webp",
        height: 32.h,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              backIcon(context),
              SizedBox(
                width: 20.w,
              ),
              Text(
                "Rates",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.white,
                  fontSize: 32.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      if (profilePictureUrl != null)
        CircleAvatar(
          radius: 50.sp,
          backgroundColor: ColorManager.grey3,
          backgroundImage: NetworkImage(profilePictureUrl!),
        ),
      if (profilePictureUrl == null)
        CircleAvatar(
          radius: 50.sp,
          backgroundColor: ColorManager.grey3,
          backgroundImage: const AssetImage("assets/images/icons/user.png"),
        ),
    ],
  );
}

Widget _peopleRateBuilder(AppFeedBack feedBack, BuildContext context) {
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
                  backgroundImage: NetworkImage(feedBack.userImageUrl!),
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
                feedBack.userName,
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
