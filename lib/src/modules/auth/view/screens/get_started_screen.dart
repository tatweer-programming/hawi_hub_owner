import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/local/shared_prefrences.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/widgets.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                authBackGround(60.h),
                BlocConsumer<MainCubit, MainState>(
                  listener: (context, state) {
                    if (state is ShowDialogState) {
                      showDialogForLanguage(context, mainCubit);
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.w, vertical: 3.5.h),
                      child: FloatingActionButton(
                        mini: true,
                        backgroundColor: ColorManager.secondary,
                        onPressed: () {
                          mainCubit.showDialog();
                        },
                        child: Icon(
                          Icons.language,
                          color: ColorManager.white,
                          size: 23.sp,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 25.w,
              ),
              child: Text(
                S.of(context).bookVenuesToPlay,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              S.of(context).getStarted,
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
              S.of(context).letsGetPlaying,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11.sp),
            ),
            SizedBox(
              height: 3.h,
            ),
            defaultButton(
              onPressed: () async {
                CacheHelper.saveData(key: "firstTime", value: false);
                context.push(
                  Routes.login,
                );
              },
              fontSize: 17.sp,
              text: S.of(context).readySteadyGo,
            ),
            SizedBox(
              height: 3.h,
            ),
            // comment for test ai commit plugin
          ],
        ),
      ),
    );
  }
}
