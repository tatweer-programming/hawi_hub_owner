import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/auth_app_bar.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../../auth/view/widgets/widgets.dart';

class AddFeedbackForUser extends StatelessWidget {
  final Owner owner;

  const AddFeedbackForUser({
    super.key,
    required this.owner,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController addCommentController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthAppBar(
              context: context,
              owner: owner,
              title: S.of(context).profile,
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              owner.userName,
              style: TextStyleManager.getTitleBoldStyle()
                  .copyWith(fontSize: 21.sp),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 6.w,
              ),
              child: Column(
                children: [
                  _rateBuilder(
                    rate: S.of(context).playerRate,
                    initialRating: 5,
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  mainFormField(
                    controller: addCommentController,
                    hint: S.of(context).addComment,
                    borderColor: ColorManager.black,
                    hintStyle: const TextStyle(
                      color: ColorManager.secondary,
                    ),
                    maxLines: 6,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  defaultButton(
                    onPressed: () {},
                    text: S.of(context).send,
                    fontSize: 18.sp,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _rateBuilder({
  required String rate,
  required double initialRating,
  required Function(double) onRatingUpdate,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        rate,
        style: TextStyleManager.getTitleBoldStyle()
            .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 1.h,
      ),
      RatingBar.builder(
        initialRating: initialRating,
        minRating: 1,
        itemSize: 25.sp,
        direction: Axis.horizontal,
        ignoreGestures: false,
        allowHalfRating: true,
        itemPadding: EdgeInsets.zero,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: ColorManager.golden,
        ),
        onRatingUpdate: onRatingUpdate,
      ),
      SizedBox(
        height: 3.h,
      ),
      Container(
        height: 0.2.h,
        width: 88.w,
        color: ColorManager.grey2,
      )
    ],
  );
}
