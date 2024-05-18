import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/localization_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/styles_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/app_notification.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/font_manager.dart';
import 'package:timeago/timeago.dart' as timeago;

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final IconData? icon;
  final double? width;
  final double? height;
  final double? radius;
  final bool isLoading;
  final bool enabled;
  const DefaultButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color,
      this.textColor,
      this.borderColor,
      this.icon,
      this.width,
      this.height,
      this.radius,
      this.isLoading = false,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 5.h,
      decoration: BoxDecoration(
        color: color ?? ColorManager.primary,
        border: Border.all(color: borderColor ?? ColorManager.primary),
        borderRadius: BorderRadius.circular(radius ?? 10),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && !isLoading)
              Icon(
                icon,
                color: textColor ?? ColorManager.white,
              ),
            SizedBox(width: 5.sp),
            isLoading
                ? CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(textColor ?? ColorManager.white),
                  )
                : Text(text,
                    style: TextStyle(
                      color: textColor ?? ColorManager.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeightManager.bold,
                    )),
          ],
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  final bool isBold;
  final Color? color;
  const TitleText(this.text, {super.key, this.isBold = true, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: isBold ? TextStyleManager.getTitleBoldStyle() : TextStyleManager.getTitleStyle());
  }
}

class SubTitle extends StatelessWidget {
  final String text;
  final bool isBold;

  const SubTitle(
    this.text, {
    this.isBold = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style:
            isBold ? TextStyleManager.getSubTitleBoldStyle() : TextStyleManager.getSubTitleStyle());
  }
}

class OutLineContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double? radius;
  final double? height;
  final double? width;
  final Color? color;
  final Color? borderColor;

  const OutLineContainer(
      {super.key,
      required this.child,
      this.onPressed,
      this.radius,
      this.height,
      this.width,
      this.color,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 5.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: borderColor ?? ColorManager.black,
            width: .5,
          ),
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final AppNotification notification;

  const NotificationWidget({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      width: 90.w,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(.1),
        borderRadius: BorderRadius.circular(180),
      ),
      child: Row(
        children: [
          if (notification.image != null)
            CircleAvatar(
              radius: 5.h,
              backgroundImage: NetworkImage(notification.image!),
              backgroundColor: ColorManager.primary,
            ),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Text(notification.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyleManager.getSubTitleBoldStyle())),
                    Text(
                        timeago.format(notification.dateTime!,
                            locale: LocalizationManager.getCurrentLocale().languageCode),
                        style: TextStyleManager.getSubTitleStyle()),
                    SizedBox(width: 1.w),
                    const FittedBox(
                        child: Icon(
                      Icons.access_time,
                    )),
                    SizedBox(width: 3.w),
                  ],
                ),
                SizedBox(height: .5.h),
                Text(notification.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getRegularStyle()),
              ]))
        ],
      ),
    );
  }
}

class FeedBackWidget extends StatelessWidget {
  final AppFeedBack feedBack;
  const FeedBackWidget({super.key, required this.feedBack});

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
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25.sp), border: Border.all()),
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 3.w, vertical: 1.h),
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
                  style:
                      TextStyle(fontSize: 12.sp, color: Colors.green, fontWeight: FontWeight.w500),
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
