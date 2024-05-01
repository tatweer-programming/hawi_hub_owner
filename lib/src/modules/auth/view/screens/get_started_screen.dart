import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            authBackGround(60.h),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 25.w,
              ),
              child: Text(
                "Book Venues to Play with Friends",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              "Get your Squad to play together!",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp),
            ),
            SizedBox(
              height: 6.h,
            ),
            Container(
              height: 0.2.h,
              width: double.infinity,
              color: ColorManager.grey2,
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              "Let's get playing!",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11.sp),
            ),
            SizedBox(
              height: 3.h,
            ),
            defaultButton(
              onPressed: () {
                context.push(Routes.login);
              },
              fontSize: 17.sp,
              text: "READY , SET , GO",
            ),
            SizedBox(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}
